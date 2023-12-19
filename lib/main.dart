import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:rao_academy/application/providers.dart';
import 'package:rao_academy/configure_firebase.dart';
import 'package:rao_academy/core/theme/custom_scroll_behaviour.dart';
import 'package:rao_academy/core/theme/theme.dart';
import 'package:rao_academy/core/utli/http_client.dart';
// import 'package:rao_academy/core/utli/error_handle.dart';
import 'package:rao_academy/core/utli/loops_urls.dart';
import 'package:rao_academy/core/utli/willpop.dart';
import 'package:rao_academy/core/widgets/colored_safe_area.dart';
// import 'package:rao_academy/firebase_options.dart';
import 'package:rao_academy/injection.dart';
import 'package:rao_academy/presentation/analytics/analytics.dart';
import 'package:rao_academy/presentation/auth/profile.dart';
import 'package:rao_academy/presentation/auth/signin.dart';
import 'package:rao_academy/presentation/auth/signin_otp.dart';
import 'package:rao_academy/presentation/auth/signup_form.dart';
import 'package:rao_academy/presentation/home/homescreen.dart';
// import 'package:rao_academy/presentation/menu.dart';
import 'package:rao_academy/presentation/other/bookmarks.dart';
import 'package:rao_academy/presentation/other/faq.dart';
import 'package:rao_academy/presentation/other/no_internet_screen.dart';
// import 'package:rao_academy/presentation/other/instructions.dart';
import 'package:rao_academy/presentation/other/notification.dart';
import 'package:rao_academy/presentation/other/refer.dart';
import 'package:rao_academy/presentation/other/subscription.dart';
import 'package:rao_academy/presentation/other/support.dart';
import 'package:rao_academy/presentation/reports/report.dart';
import 'package:rao_academy/presentation/results/result.dart';
// import 'package:rao_academy/presentation/results/sprint_history.dart';
import 'package:rao_academy/presentation/results/widgets/test_results.dart';
import 'package:rao_academy/presentation/splash/splash1.dart';
import 'package:rao_academy/presentation/splash/splash_screen.dart';
import 'package:rao_academy/presentation/test_screens/all_chapters.dart';
import 'package:rao_academy/presentation/test_screens/concept_based.dart';
import 'package:rao_academy/presentation/test_screens/custom_test.dart';
import 'package:rao_academy/presentation/test_screens/test_history.dart';
import 'package:rao_academy/presentation/test_screens/test_home.dart';
import 'package:rao_academy/presentation/test_screens/test_instructions.dart';
import 'package:rao_academy/presentation/test_screens/test_screen.dart';
import 'package:rao_academy/presentation/test_screens/test_summary.dart';
import 'package:rao_academy/presentation/test_screens/test_types/loops.dart';
import 'package:upgrader/upgrader.dart';
ConnectivityResult connectivityResult = ConnectivityResult.none;
bool isEnterHomeScreen = false;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  connectivityResult = await (Connectivity().checkConnectivity());
  await Upgrader.clearSavedSettings();
  configureInjection(Environment.dev);
  await configureApp();
  await checkUpdate();
  runApp(const MediaQuery(data: MediaQueryData(), child: MyApp()));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> checkUpdate() async {
  try {
    await InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability.value == 2) {
        InAppUpdate.performImmediateUpdate();
      }
    }).catchError((e) {
      // handleError(e);
    });
    // ignore: avoid_catches_without_on_clauses
  } catch (_) {}
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

StreamSubscription<ConnectivityResult>? _subscription;
bool isAttampNoInternet = false;


checkInternetConnectity() async{
   connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    // I am connected to a mobile network.
  } else if (connectivityResult == ConnectivityResult.wifi) {
    // I am connected to a wifi network.
  } else if (connectivityResult == ConnectivityResult.ethernet) {
    // I am connected to a ethernet network.
  } else if (connectivityResult == ConnectivityResult.vpn) {
    // I am connected to a vpn network.
    // Note for iOS and macOS:
    // There is no separate network interface type for [vpn].
    // It returns [other] on any device (also simulator)
  } else if (connectivityResult == ConnectivityResult.bluetooth) {
    // I am connected to a bluetooth.
  } else if (connectivityResult == ConnectivityResult.other) {
    // I am connected to a network which is not in the above mentioned networks.
  } else if (connectivityResult == ConnectivityResult.none) {
    isAttampNoInternet = true;
    Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (context) => NoInternetScreen(),));
    // I am not connected to any network.
  }
}


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkInternetConnectity();
    _subscription = Connectivity().onConnectivityChanged.listen((event) {
      connectivityResult = event;
      if(connectivityResult == ConnectivityResult.mobile){
        if (kDebugMode) {
          print("-------------Internet---------------");
        }
        if(isAttampNoInternet){
          if(isEnterHomeScreen){
            Navigator.pop(navigatorKey.currentContext!);

          }else{
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SplashScreen(),), (route) => false);
          }

        }

      }else if(connectivityResult == ConnectivityResult.wifi){
        if (kDebugMode) {
          print("-------------Internet---------------");
        }
        if(isAttampNoInternet){
          if(isEnterHomeScreen){
            Navigator.pop(navigatorKey.currentContext!);

          }else{
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SplashScreen(),), (route) => false);
          }

        }
      }else{

          isAttampNoInternet = true;
          Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (context) => NoInternetScreen(),));

      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(milliseconds: 1)).then(
    //     (value) => SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //           systemNavigationBarColor: LoopsColors.colorBlack,
    //           systemNavigationBarDividerColor: LoopsColors.colorBlack,
    //           systemNavigationBarIconBrightness: Brightness.light,
    //           statusBarColor: LoopsColors.colorBlack,
    //           statusBarBrightness: Brightness.light,
    //           statusBarIconBrightness: Brightness.light,
    //         )));
    // SystemChrome.setEnabledSystemUIMode(
    //   SystemUiMode.manual,
    //   overlays: [
    //     SystemUiOverlay.top, // Shows Status bar and hides Navigation bar
    //   ],
    // );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: const Color(0x00000000)));
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );

    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: MultiProvider(
        providers: List.from(providers),
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (BuildContext context, _) {
            final brightness = MediaQuery.of(context).platformBrightness;
            final bool isDarkMode = brightness == Brightness.dark;
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: MaterialApp(
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'LOOPs App',
                theme: appTheme,
                initialRoute: '/splashScreen',
                // navigatorObservers: <NavigatorObserver>[observer],
                routes: <String, WidgetBuilder>{
                  '/splashScreen': (BuildContext context) {
                    return const SplashScreen();
                  },
                  '/info01': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const Info01(),
                    );
                  },
                  '/signIn': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const SignIn(),
                    );
                  },
                  '/signInOTP': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const SignInOTP(),
                    );
                  },
                  '/signUpForm': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const SignUpForm(),
                    );
                  },
                  '/homeScreen': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const HomeScreen(),
                    );
                  },
                  /*  '/dragNDrop': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const DragNDrop(),
                    );
                  },
                  '/mcq': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const MCQ(),
                    );
                  },
                  '/tof': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const TOF(),
                    );
                  },
                  '/mcqImage': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const MCQImage(),
                    );
                  }, */
                  '/results': (BuildContext context) {
                    final args = ModalRoute.of(context)!.settings.arguments
                        as Map<String, dynamic>;
                    final index = (args['index'] as int);
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: Results(
                        index: index,
                      ),
                    );
                  },
                  '/refer': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const Refer(),
                    );
                  },
                  '/subscription': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const Subcription(),
                    );
                  },
                  /* '/menu': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const Menu(),
                    );
                  }, */
                  '/faq': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const FAQ(),
                    );
                  },
                  '/profile': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const Profile(),
                    );
                  },
                  '/bookmarks': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const Bookmarks(),
                    );
                  },
                  '/testHome': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const TestHome(),
                    );
                  },
                  '/customTest': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const CustomTest(),
                    );
                  },
                  /* '/instructions': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const Instructions(),
                    );
                  }, */
                  '/testHistory': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child:  TestHistory(),
                    );
                  },
                  '/support': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const Support(),
                    );
                  },
                  '/analyticsPage': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const AnalyticsPage(),
                    );
                  },
                  /*  '/matchTheFollowing': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const MathTheFollowing(),
                    );
                  },
                  '/matchTheFollowingImage': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const MathTheFollowingImage(),
                    );
                  }, */
                  '/loops': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const Loops(),
                    );
                  },
                  '/testResults': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child:  SprintHome(testName: ""),
                    );
                  },
                  '/reports': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const Reports(),
                    );
                  },
                  '/notification': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const NotificationPage(),
                    );
                  },
                  '/testSummary': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child:  TestSummary(isShowResumeButton: true),
                    );
                  },
                  '/allChapters': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const AllChapters(),
                    );
                  },
                  '/conceptBased': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const ConceptBased(),
                    );
                  },
                  '/testInstructions': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child:  TestInstructions(testType: ""),
                    );
                  },
                  '/sprintHistory': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child:  SprintHome(testName: ""),
                    );
                  },
                  /*  '/fill': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const Fill(),
                    );
                  }, */
                  '/testScreen': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const TestScreen(),
                    );
                  },
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
