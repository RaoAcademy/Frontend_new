import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> configureApp() async {
  await inititializeFirebase();
  log('@@@@@@@@@@@@@@@@@@@@@@@@@ Non Web @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
}

Future<void> inititializeFirebase() async {
  // final FirebaseAnalytics analytics = FirebaseAnalytics();
  // final FirebaseAnalyticsObserver observer =
  //     FirebaseAnalyticsObserver(analytics: analytics);
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}
