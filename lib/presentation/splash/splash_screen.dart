import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:version/version.dart';
import '../../application/auth/auth_provider.dart';
import '../../application/firebase/firebase_notification_provider.dart';
import '../../application/home/home_provider.dart';
import '../../application/other/other_provider.dart';
import '../../core/utli/error_handle.dart';
import '../../core/utli/goto_pages.dart';
import '../../core/utli/loops_urls.dart';
import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    if (connectivityResult != ConnectivityResult.none) {
    context.read<FirebaseNotificationProvider>().initialize();
    final provider = Provider.of<HomeProvider>(context, listen: false);
    provider.fappVersion().then((_) async{
      provider.getCurrentVersion().then((_) async {
        if (!(provider.currentVersion <
            Version.parse(
                '${provider.appVersionEntity.version ?? 0}'))) {
          AppUpdateInfo res =  await InAppUpdate.checkForUpdate();
          handleError(
              'Please update the App to: ${provider.appVersionEntity
                  .version}');
          if(res.immediateUpdateAllowed){
             await InAppUpdate.performImmediateUpdate();

          }else{
            Provider.of<AuthAppProvider>(context, listen: false)
                .getUserId()
                .then((value) {
              if (value != 0) {
                Provider.of<AuthAppProvider>(context, listen: false).fprofile();
                Provider.of<AuthAppProvider>(context, listen: false)
                    .fprofileDetailed()
                    .then((_) {
                  gotoHomePage(context).onError((error, stackTrace) {
                    Fluttertoast.showToast(msg: 'Error in fhome API:\n$error');
                  }).onError((error, stackTrace) async {
                    await handleError(error);
                  });
                }).onError((error, stackTrace) async {
                  await handleError(error);
                });
              } else {
                context.read<AuthAppProvider>().getInstallKey().then((value) {
                  if (value != 1) {
                    gotoSplashScreen(context);
                  } else {
                    Provider
                        .of<OtherProvider>(context, listen: false)
                        .routeNames
                        .add('/signIn');
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/signIn',
                          (route) => false,
                    );
                  }
                });
                /*  Navigator.pushNamedAndRemoveUntil(
                context,
                '/signIn',
                (route) => false,
              ); */
              }
              context.read<AuthAppProvider>().setOnceInstallKey();
            });
          }


        } else {
          Provider.of<AuthAppProvider>(context, listen: false)
              .getUserId()
              .then((value) {
            if (value != 0) {
              Provider.of<AuthAppProvider>(context, listen: false).fprofile();
              Provider.of<AuthAppProvider>(context, listen: false)
                  .fprofileDetailed()
                  .then((_) {
                gotoHomePage(context).onError((error, stackTrace) {
                  Fluttertoast.showToast(msg: 'Error in fhome API:\n$error');
                }).onError((error, stackTrace) async {
                  await handleError(error);
                });
              }).onError((error, stackTrace) async {
                await handleError(error);
              });
            } else {
              context.read<AuthAppProvider>().getInstallKey().then((value) {
                if (value != 1) {
                  gotoSplashScreen(context);
                } else {
                  Provider
                      .of<OtherProvider>(context, listen: false)
                      .routeNames
                      .add('/signIn');
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/signIn',
                        (route) => false,
                  );
                }
              });
              /*  Navigator.pushNamedAndRemoveUntil(
                context,
                '/signIn',
                (route) => false,
              ); */
            }
            context.read<AuthAppProvider>().setOnceInstallKey();
          });
        }
      });
    });
  }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LoopsColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  /*  SvgPicture.asset(
                    'assets/icons/logos/loops.svg',
                    color: LoopsColors.tertiaryColor,
                    matchTextDirection: true,
                    height: 38.h,
                  ),
                  SvgPicture.asset(
                    'assets/icons/logos/line.svg',
                    color: LoopsColors.colorWhite,
                    matchTextDirection: true,
                    height: 38.h,
                  ), */
                  Text(
                    'EdTestz',
                    style: TextStyle(
                      fontFamily: 'Hurme',
                      fontSize: 44,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.5.sp,
                      color: LoopsColors.colorWhite,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
