import 'dart:async';
import 'dart:io';

import 'package:EdTestz/application/providers.dart';
import 'package:EdTestz/configure_firebase.dart';
import 'package:EdTestz/core/theme/custom_scroll_behaviour.dart';
import 'package:EdTestz/core/theme/theme.dart';
import 'package:EdTestz/core/utli/http_client.dart';
// import 'package:EdTestz/core/utli/error_handle.dart';
import 'package:EdTestz/core/utli/loops_urls.dart';
import 'package:EdTestz/core/utli/willpop.dart';
import 'package:EdTestz/core/widgets/colored_safe_area.dart';
// import 'package:EdTestz/firebase_options.dart';
import 'package:EdTestz/injection.dart';
import 'package:EdTestz/presentation/Scheduled%20Tests/scheduled_tests.dart';
import 'package:EdTestz/presentation/analytics/analytics.dart';
import 'package:EdTestz/presentation/auth/profile.dart';
import 'package:EdTestz/presentation/auth/signin.dart';
import 'package:EdTestz/presentation/auth/signin_otp.dart';
import 'package:EdTestz/presentation/auth/signup_form.dart';
import 'package:EdTestz/presentation/home/homescreen.dart';
// import 'package:EdTestz/presentation/menu.dart';
import 'package:EdTestz/presentation/other/bookmarks.dart';
import 'package:EdTestz/presentation/other/faq.dart';
import 'package:EdTestz/presentation/other/no_internet_screen.dart';
// import 'package:EdTestz/presentation/other/instructions.dart';
import 'package:EdTestz/presentation/other/notification.dart';
import 'package:EdTestz/presentation/other/refer.dart';
import 'package:EdTestz/presentation/other/subscription.dart';
import 'package:EdTestz/presentation/other/support.dart';
import 'package:EdTestz/presentation/reports/report.dart';
import 'package:EdTestz/presentation/results/result.dart';
// import 'package:EdTestz/presentation/results/sprint_history.dart';
import 'package:EdTestz/presentation/results/widgets/test_results.dart';
import 'package:EdTestz/presentation/splash/splash1.dart';
import 'package:EdTestz/presentation/splash/splash_screen.dart';
import 'package:EdTestz/presentation/test_screens/all_chapters.dart';
import 'package:EdTestz/presentation/test_screens/concept_based.dart';
import 'package:EdTestz/presentation/test_screens/custom_test.dart';
import 'package:EdTestz/presentation/test_screens/test_history.dart';
import 'package:EdTestz/presentation/test_screens/test_home.dart';
import 'package:EdTestz/presentation/test_screens/test_instructions.dart';
import 'package:EdTestz/presentation/test_screens/test_screen.dart';
import 'package:EdTestz/presentation/test_screens/test_summary.dart';
import 'package:EdTestz/presentation/test_screens/test_types/loops.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

import 'firebase_options.dart';

ConnectivityResult connectivityResult = ConnectivityResult.none;
bool isEnterHomeScreen = false;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
    // options: const FirebaseOptions(
    //   appId: '1:461953966814:android:d92c01cb2f95084aebd84f',
    //   apiKey: 'AIzaSyDIuFEFN8KzSBpHe-6gPeB82xPUVTiVgRA',
    //   messagingSenderId: 'your_sender_id',
    //   projectId: 'rao-academy-63914',
    //   // Set the locale
    //   // locale: 'en', // Or any other locale code
    // ),
  );
  connectivityResult = await Connectivity().checkConnectivity();
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

  checkInternetConnectity() async {
    connectivityResult = await Connectivity().checkConnectivity();
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
      await Navigator.push(
          navigatorKey.currentContext!,
          MaterialPageRoute(
            builder: (context) => const NoInternetScreen(),
          ));
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
      if (connectivityResult == ConnectivityResult.mobile) {
        if (kDebugMode) {
          print('-------------Internet---------------');
        }
        if (isAttampNoInternet) {
          if (isEnterHomeScreen) {
            Navigator.pop(navigatorKey.currentContext!);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
                (route) => false);
          }
        }
      } else if (connectivityResult == ConnectivityResult.wifi) {
        if (kDebugMode) {
          print('-------------Internet---------------');
        }
        if (isAttampNoInternet) {
          if (isEnterHomeScreen) {
            Navigator.pop(navigatorKey.currentContext!);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
                (route) => false);
          }
        }
      } else {
        isAttampNoInternet = true;
        Navigator.push(
            navigatorKey.currentContext!,
            MaterialPageRoute(
              builder: (context) => const NoInternetScreen(),
            ));
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
                  '/ScheduledTests': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: const ScheduledTestsScreen(),
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
                    final index = args['index'] as int;
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
                      child: TestHistory(),
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
                      child: SprintHome(testName: ''),
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
                      child: TestSummary(isShowResumeButton: true),
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
                      child: TestInstructions(testType: ''),
                    );
                  },
                  '/sprintHistory': (BuildContext context) {
                    return ColoredSafeArea(
                      color: isDarkMode
                          ? LoopsColors.colorWhite
                          : LoopsColors.colorBlack,
                      child: SprintHome(testName: ''),
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
