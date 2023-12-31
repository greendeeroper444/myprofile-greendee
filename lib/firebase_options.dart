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
    apiKey: 'AIzaSyAWOBGSWTlMseYNxX-20VKd71bzCObhYrU',
    appId: '1:545197728865:web:eeb30f0f4fef25ddc97620',
    messagingSenderId: '545197728865',
    projectId: 'myprofile-greendee',
    authDomain: 'myprofile-greendee.firebaseapp.com',
    storageBucket: 'myprofile-greendee.appspot.com',
    measurementId: 'G-5TMR27SXHQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBvDcgJMYLwNEnkOvRYP2F3Ur3AtSROjn4',
    appId: '1:545197728865:android:1b7d9d67b5694ecac97620',
    messagingSenderId: '545197728865',
    projectId: 'myprofile-greendee',
    storageBucket: 'myprofile-greendee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDVvLMt7RffnQTpCdyR3zTSsyTJPIJ_VhQ',
    appId: '1:545197728865:ios:46ce653872b67d60c97620',
    messagingSenderId: '545197728865',
    projectId: 'myprofile-greendee',
    storageBucket: 'myprofile-greendee.appspot.com',
    iosBundleId: 'com.example.myprofileGreendee',
  );
}
