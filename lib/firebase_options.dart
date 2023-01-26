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
    apiKey: 'AIzaSyBIh3A205_15Lcsih_EPwCLiqa0wqDmqa4',
    appId: '1:824827103730:web:7218ec5613fdb1750f836b',
    messagingSenderId: '824827103730',
    projectId: 'darkstore-lastver',
    authDomain: 'darkstore-lastver.firebaseapp.com',
    storageBucket: 'darkstore-lastver.appspot.com',
    measurementId: 'G-Z852BWDN49',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBcPL95ML1D8pg7GyyNNxGBGMzxhItEjzg',
    appId: '1:824827103730:android:b78ff35ccb00dca50f836b',
    messagingSenderId: '824827103730',
    projectId: 'darkstore-lastver',
    storageBucket: 'darkstore-lastver.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyABXjhMU7DW3ZZ1nbnf4EVVSDNG_8AmaRs',
    appId: '1:824827103730:ios:1dd8ff738c88b45b0f836b',
    messagingSenderId: '824827103730',
    projectId: 'darkstore-lastver',
    storageBucket: 'darkstore-lastver.appspot.com',
    androidClientId: '824827103730-e91g4vt8m2rq67dbn63ssgsreh3vko1d.apps.googleusercontent.com',
    iosClientId: '824827103730-h28c0pmalg86tidtod7pjgd19nb4h2o2.apps.googleusercontent.com',
    iosBundleId: 'com.example.dashboardstore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyABXjhMU7DW3ZZ1nbnf4EVVSDNG_8AmaRs',
    appId: '1:824827103730:ios:1dd8ff738c88b45b0f836b',
    messagingSenderId: '824827103730',
    projectId: 'darkstore-lastver',
    storageBucket: 'darkstore-lastver.appspot.com',
    androidClientId: '824827103730-e91g4vt8m2rq67dbn63ssgsreh3vko1d.apps.googleusercontent.com',
    iosClientId: '824827103730-h28c0pmalg86tidtod7pjgd19nb4h2o2.apps.googleusercontent.com',
    iosBundleId: 'com.example.dashboardstore',
  );
}