// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBwaT-n9hiBm_-geSqA8J2owcG8jAjfztM',
    appId: '1:223514486202:web:9308b49971bcce4be26983',
    messagingSenderId: '223514486202',
    projectId: 'projectx-baaee',
    authDomain: 'projectx-baaee.firebaseapp.com',
    storageBucket: 'rao-academy-63914.appspot.com',
    measurementId: 'G-5CB6XG0PML',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDIuFEFN8KzSBpHe-6gPeB82xPUVTiVgRA',
    appId: '1:461953966814:android:d92c01cb2f95084aebd84f',
    messagingSenderId: '461953966814',
    projectId: 'rao-academy-63914',
    storageBucket: 'rao-academy-63914.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB51Sp0vugnAHklpBH0czELJzm_0ySSRHM',
    appId: '1:223514486202:ios:0b094dab92a8ffb4e26983',
    messagingSenderId: '223514486202',
    projectId: 'rao-academy-63914',
    storageBucket: 'rao-academy-63914.appspot.com',
    androidClientId:
        '223514486202-vdsqd1lt4drq5mac2e08f19t3gkm76j6.apps.googleusercontent.com',
    iosClientId:
        '223514486202-htgl7667rj7j16jnehu347n0t2gttuo3.apps.googleusercontent.com',
    iosBundleId: 'com.app.raoacademy',
  );
}