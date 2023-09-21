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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBNfyAgNdowZ5uWRaMe5cbV4v4olbNVByg',
    appId: '1:246161893617:android:e3357e4f400165f84ba150',
    messagingSenderId: '246161893617',
    projectId: 'flutter-firebase-starter-7c77a',
    storageBucket: 'flutter-firebase-starter-7c77a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpcjIemdCGFRNkTWNKq6BsljeTWvYQR8E',
    appId: '1:246161893617:ios:fe8920731f0f8a1b4ba150',
    messagingSenderId: '246161893617',
    projectId: 'flutter-firebase-starter-7c77a',
    storageBucket: 'flutter-firebase-starter-7c77a.appspot.com',
    iosClientId: '246161893617-p5l248h4ksvbto2mo5b2pfavoq1crs35.apps.googleusercontent.com',
    iosBundleId: 'com.example.islandTourPlanner',
  );
}
