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
        return macos;
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
    apiKey: 'AIzaSyBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
    appId: '1:xxxxxxxxx:web:xxxxxxxxxxxxxxxxx',
    messagingSenderId: 'xxxxxxxxx',
    projectId: 'fitness-tracker-xxxxx',
    authDomain: 'fitness-tracker-xxxxx.firebaseapp.com',
    storageBucket: 'fitness-tracker-xxxxx.appspot.com',
    measurementId: 'G-XXXXXXXXXX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
    appId: '1:xxxxxxxxx:android:xxxxxxxxxxxxxxxxx',
    messagingSenderId: 'xxxxxxxxx',
    projectId: 'fitness-tracker-xxxxx',
    storageBucket: 'fitness-tracker-xxxxx.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
    appId: '1:xxxxxxxxx:ios:xxxxxxxxxxxxxxxxx',
    messagingSenderId: 'xxxxxxxxx',
    projectId: 'fitness-tracker-xxxxx',
    storageBucket: 'fitness-tracker-xxxxx.appspot.com',
    iosBundleId: 'com.example.fitnessTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
    appId: '1:xxxxxxxxx:ios:xxxxxxxxxxxxxxxxx',
    messagingSenderId: 'xxxxxxxxx',
    projectId: 'fitness-tracker-xxxxx',
    storageBucket: 'fitness-tracker-xxxxx.appspot.com',
    iosBundleId: 'com.example.fitnessTracker',
  );
}
