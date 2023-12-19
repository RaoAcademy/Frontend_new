import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:rao_academy/core/utli/goto_pages.dart';
// import 'package:rao_academy/core/utli/copy_text.dart';
import 'package:rao_academy/core/utli/logger.dart';
import 'package:rao_academy/main.dart';

String fcmTokenGlobal = '';

@injectable
class FirebaseNotificationProvider with ChangeNotifier {
  bool permissionGranted = false;
  String? fcmToken = '';
  //String? apnsToken = '';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'firebase_notification_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  Future initialize() async {
    final NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      permissionGranted = true;

      fcmToken = await FirebaseMessaging.instance.getToken();

      // if (Platform.isIOS) {
      //   apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      // }

      logger.d('fcmToken: $fcmToken');
      // copyToClipboard(navigatorKey.currentContext!, fcmToken!);
      //logger.d('apnsToken: $apnsToken');

      fcmTokenGlobal = fcmToken ?? '';

      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/launcher_icon');

      /*  const IOSInitializationSettings initializationSettingsIOS =
          IOSInitializationSettings();
 */
      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        // iOS: initializationSettingsIOS,
      );

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        // onSelectNotification: selectNotification,
      );

      if (Platform.isAndroid) {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
      }

      FirebaseMessaging.instance.onTokenRefresh.listen(
        (newToken) {
          fcmToken = newToken;
          //logger.d('token: $newToken');
          fcmTokenGlobal = newToken;
        },
      );

      // Shows notification when the app is in foreground
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) async {
          if (message.notification != null &&
              message.notification!.android != null) {
            await flutterLocalNotificationsPlugin.show(
              message.notification.hashCode,
              message.notification!.title,
              message.notification!.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  // channel.description,
                  color: Colors.white,
                  styleInformation: const BigTextStyleInformation(''),
                ),
              ),
              //payload: message.data['msg'].toString(),
            );
          }
          // await handleRedirection(message);
          // await navigatorKey.currentState!
          //     .pushNamedAndRemoveUntil('/splashScreen', (route) => false);
        },
      );

      // Executes when background notification is tapped by the user
      FirebaseMessaging.onMessageOpenedApp.listen(
        (RemoteMessage message) async {
          logger.i(message);
          logger.i(message.data);
          await handleRedirection(message);
          // await flutterLocalNotificationsPlugin.cancelAll();
        },
      );
    }
  }

  Future<void> handleRedirection(RemoteMessage message) async {
    switch (message.data['screen']) {
      case 'fsubscription':
        await gotoSubscription(navigatorKey.currentContext!);
        break;
      case 'ftestHome':
        await gotoTestHome(navigatorKey.currentContext!);
        break;
      case 'fprofile':
        await gotoProfile(navigatorKey.currentContext!);
        break;
      case 'fhome':
        await gotoHomePage(navigatorKey.currentContext!);
        break;
      case 'freports':
        await gotoReports(navigatorKey.currentContext!,false);
        break;
      case 'fanalytics':
        await gotoAnalyticsPage(navigatorKey.currentContext!);
        break;
      default:
        await flutterLocalNotificationsPlugin.cancelAll();
    }
  }

  // Executes when foreground notification is tapped by the user
  Future selectNotification(String? payload) async {
    await flutterLocalNotificationsPlugin.cancelAll();

    /* if (payload != null) {
      logger.d('payload: $payload');

      Future.delayed(
        Duration.zero,
        () async {
         showCupertinoDialog(
            context: navigatorKey.currentContext!,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                content: Text(payload),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Okay'),
                  ),
                ],
              );
            },
          );
        },
      );
    } */
  }
}
