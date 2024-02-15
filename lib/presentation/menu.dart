/* import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/auth/auth_provider.dart';
import 'package:EdTestz/application/firebase/firebase_notification_provider.dart';
import 'package:EdTestz/application/home/home_provider.dart';
import 'package:EdTestz/application/other/other_provider.dart';
import 'package:EdTestz/application/test/test_provider.dart';
import 'package:EdTestz/core/theme/custom_scroll_behaviour.dart';
import 'package:EdTestz/core/utli/error_handle.dart';
import 'package:EdTestz/core/utli/goto_pages.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/widgets/custom_button.dart';
import 'package:EdTestz/core/widgets/logout_popup.dart';
import 'package:EdTestz/core/widgets/rate_app.dart';
import 'package:EdTestz/presentation/auth/widgets/add_school.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    context.read<AuthProvider>().getVersionData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final OtherProvider otherProvider = context.watch<OtherProvider>();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 62.w),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
              children: [
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .fsignup(fcmToken: fcmTokenGlobal)
                        .then((_) {
                      addSchool(context);
                    });
                  },
                  lable: 'addSchool',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(
                      '/splashScreen',
                      (route) => false,
                    )
                        .then((_) {
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .add('/splashScreen');
                    });
                  },
                  lable: 'splashScreen',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    gotoSplashScreen(context);
                  },
                  lable: 'info01',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/signIn',
                    ).then((_) {
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .add('/signIn');
                    });
                  },
                  lable: 'signIn',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/signInOTP',
                    ).then((_) {
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .add('/signInOTP');
                    });
                  },
                  lable: 'signInOTP',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    gotoSignupPage(context);
                  },
                  lable: 'signUpForm',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .getUserId()
                        .then((value) {
                      if (value != 0) {
                        Provider.of<HomeProvider>(context, listen: false)
                            .fhome()
                            .then((_) {
                          gotoHomePage(context);
                        }).onError((error, stackTrace) {
                          Fluttertoast.showToast(
                              msg: 'Error in fhome API:\n$error');
                        });
                      }
                    });
                  },
                  lable: 'homeScreen',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/dragNDrop',
                    ).then((_) {
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .add('/dragNDrop');
                    });
                  },
                  lable: 'dragNDrop',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/mcq',
                    ).then((_) {
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .add('/mcq');
                    });
                  },
                  lable: 'mcq',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/tof',
                    ).then((_) {
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .add('/tof');
                    });
                  },
                  lable: 'tof',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/mcqImage',
                    ).then((_) {
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .add('/mcqImage');
                    });
                  },
                  lable: 'mcqImage',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    gotoResults(context, null);
                  },
                  lable: 'results',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    gotoReferral(context);
                  },
                  lable: 'refer',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    gotoSubscription(context);
                  },
                  lable: 'subcription',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    showLogoutPopup(context);
                  },
                  lable: 'Logout',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    rateApp(context, otherProvider);
                  },
                  lable: 'Rate App',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    gotoFAQs(context, 'all');
                  },
                  lable: 'faq',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/profile',
                    ).then((_) {
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .add('/profile');
                    });
                  },
                  lable: 'profile',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false)
                        .fbookmarkTest()
                        .then((value) => {
                              Navigator.pushNamed(
                                context,
                                '/bookmarks',
                              ).then((_) {
                                Provider.of<OtherProvider>(context,
                                        listen: false)
                                    .routeNames
                                    .add('/bookmarks');
                              }),
                            })
                        .onError((error, stackTrace) async {
                      await handleError(error);
                      throw error!;
                    });
                  },
                  lable: 'bookmarks',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    gotoTestHome(context);
                  },
                  lable: 'testHome',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/customTest',
                    ).then((_) {
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .add('/customTest');
                    });
                  },
                  lable: 'customTest',
                ),
                SizedBox(
                  height: 24.h,
                ),
                /* CustomButton(
                  onTap: () {
                    Provider.of<TestProvider>(context, listen: false)
                        .ftestInstructions()
                        .then((value) {
                      Navigator.pushNamed(
                        context,
                        '/instructions',
                      ).then((_) {
                        Provider.of<OtherProvider>(context, listen: false)
                            .routeNames
                            .add('/instructions');
                      });
                    }).onError((error, stackTrace) async {
                      await handleError(error);
                      throw error!;
                    });
                  },
                  lable: 'instructions',
                ),
                SizedBox(
                  height: 24.h,
                ), */
                CustomButton(
                  onTap: () {
                    gotoTestHistory(context);
                  },
                  lable: 'testHistory',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/support',
                    ).then((_) {
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .add('/support');
                    });
                  },
                  lable: 'support',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    gotoAnalyticsPage(context);
                  },
                  lable: 'analyticsPage',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/matchTheFollowing',
                    ).then((_) {
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .add('/matchTheFollowing');
                    });
                  },
                  lable: 'mathcTheFollowing',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/matchTheFollowingImage',
                    ).then((_) {
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .add('/matchTheFollowingImage');
                    });
                  },
                  lable: 'matchTheFollowingImage',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    Provider.of<TestProvider>(context, listen: false)
                        .floopsHome()
                        .then(
                          (value) => Navigator.pushNamed(
                            context,
                            '/loops',
                          ).then((_) {
                            Provider.of<OtherProvider>(context, listen: false)
                                .routeNames
                                .add('/loops');
                          }),
                        )
                        .onError((error, stackTrace) async {
                      await handleError(error);
                      throw error!;
                    });
                  },
                  lable: 'loops',
                ),
                SizedBox(
                  height: 24.h,
                ),
                /*  CustomButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/testResults',
                    ).then((_) {
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .add('/testResults');
                    });
                  },
                  lable: 'testResults',
                ),
                SizedBox(
                  height: 24.h,
                ), */
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/notification',
                    ).then((_) {
                      Provider.of<OtherProvider>(context, listen: false)
                          .routeNames
                          .add('/notification');
                    });
                  },
                  lable: 'notification',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    gotoReports(context);
                  },
                  lable: 'reports',
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomButton(
                  onTap: () {
                    gotoTestSummary(context);
                  },
                  lable: 'testSummary',
                ),
                SizedBox(
                  height: 24.h,
                ),
                SizedBox(
                  height: 80.h,
                  child: Center(
                    child: Text(
                      'Version: ${context.watch<AuthProvider>().currentVersion.major}.${context.watch<AuthProvider>().currentVersion.minor}.${context.watch<AuthProvider>().currentVersion.patch} (${context.watch<AuthProvider>().currentVersion.build})',
                      style: TextStyle(
                          color: LoopsColors.colorBlack.withAlpha(120)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 */
