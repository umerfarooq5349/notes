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
    apiKey: 'AIzaSyC8rc4cncnyJw9CWwu0KS0K0tchR3HPr04',
    appId: '1:411510578910:web:f0c6755f62c780a77c6c4f',
    messagingSenderId: '411510578910',
    projectId: 'note--s',
    authDomain: 'note--s.firebaseapp.com',
    storageBucket: 'note--s.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZqQIU35MvbR2kQRKx0s9oCHtAX2KUpwE',
    appId: '1:411510578910:android:08f4a6be55246baf7c6c4f',
    messagingSenderId: '411510578910',
    projectId: 'note--s',
    storageBucket: 'note--s.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZxQ3ZoIwiP1faPcfD7hwlpREXO4jqRh8',
    appId: '1:411510578910:ios:78f4cf10252aa3f67c6c4f',
    messagingSenderId: '411510578910',
    projectId: 'note--s',
    storageBucket: 'note--s.appspot.com',
    iosBundleId: 'com.example.notes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZxQ3ZoIwiP1faPcfD7hwlpREXO4jqRh8',
    appId: '1:411510578910:ios:7d56bbce1ae051a87c6c4f',
    messagingSenderId: '411510578910',
    projectId: 'note--s',
    storageBucket: 'note--s.appspot.com',
    iosBundleId: 'com.example.notes.RunnerTests',
  );
}
