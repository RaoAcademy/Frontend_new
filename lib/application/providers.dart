import 'package:EdTestz/presentation/Scheduled%20Tests/shedual_test_provider.dart';
import 'package:provider/provider.dart';
import 'package:EdTestz/application/auth/auth_provider.dart';
import 'package:EdTestz/application/firebase/firebase_notification_provider.dart';
import 'package:EdTestz/application/home/home_provider.dart';
import 'package:EdTestz/application/other/other_provider.dart';
import 'package:EdTestz/application/payment/payment_provider.dart';
import 'package:EdTestz/application/splash/splash_provider.dart';
import 'package:EdTestz/application/test/test_provider.dart';
import 'package:EdTestz/injection.dart';

final List providers = [
  ChangeNotifierProvider<SplashProvider>(
    create: (context) => getIt<SplashProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<AuthAppProvider>(
    create: (context) => getIt<AuthAppProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<HomeProvider>(
    create: (context) => getIt<HomeProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<TestProvider>(
    create: (context) => getIt<TestProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<OtherProvider>(
    create: (context) => getIt<OtherProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<FirebaseNotificationProvider>(
    create: (context) => getIt<FirebaseNotificationProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<PaymentProvider>(
    create: (context) => getIt<PaymentProvider>(),
    lazy: false,
  ),ChangeNotifierProvider<ScheduleTestProvider>(
    create: (context) => ScheduleTestProvider(),
  ),
];
