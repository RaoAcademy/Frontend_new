import 'package:provider/provider.dart';
import 'package:rao_academy/application/auth/auth_provider.dart';
import 'package:rao_academy/application/firebase/firebase_notification_provider.dart';
import 'package:rao_academy/application/home/home_provider.dart';
import 'package:rao_academy/application/other/other_provider.dart';
import 'package:rao_academy/application/payment/payment_provider.dart';
import 'package:rao_academy/application/splash/splash_provider.dart';
import 'package:rao_academy/application/test/test_provider.dart';
import 'package:rao_academy/injection.dart';

final List providers = [
  ChangeNotifierProvider<SplashProvider>(
    create: (context) => getIt<SplashProvider>(),
    lazy: false,
  ),
  ChangeNotifierProvider<AuthProvider>(
    create: (context) => getIt<AuthProvider>(),
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
  ),
];
