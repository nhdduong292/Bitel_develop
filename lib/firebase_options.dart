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
    apiKey: 'AIzaSyDU-DWcIXnsX-td_yvcKGSah6nvIb7cLZM',
    appId: '1:687680612219:web:f725ebc3273c4613ba7fde',
    messagingSenderId: '687680612219',
    projectId: 'bitel-ventas-9cd08',
    authDomain: 'bitel-ventas-9cd08.firebaseapp.com',
    storageBucket: 'bitel-ventas-9cd08.appspot.com',
    measurementId: 'G-90804GDMHJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBkvGxvhfz26HyvM5YwkUyzpgZQwKkWOwQ',
    appId: '1:687680612219:android:c6d52f5546a0dea0ba7fde',
    messagingSenderId: '687680612219',
    projectId: 'bitel-ventas-9cd08',
    storageBucket: 'bitel-ventas-9cd08.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDixC0kT-L1tRDDXYi_7P3HrIxTydXj_9w',
    appId: '1:687680612219:ios:a4ec71c5cd69f716ba7fde',
    messagingSenderId: '687680612219',
    projectId: 'bitel-ventas-9cd08',
    storageBucket: 'bitel-ventas-9cd08.appspot.com',
    iosClientId: '687680612219-6kfbnjg7p9cq81d7frsl684e10topkpn.apps.googleusercontent.com',
    iosBundleId: 'com.bitel.bss.viettelpos.v3.bitelVentas',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDixC0kT-L1tRDDXYi_7P3HrIxTydXj_9w',
    appId: '1:687680612219:ios:a4ec71c5cd69f716ba7fde',
    messagingSenderId: '687680612219',
    projectId: 'bitel-ventas-9cd08',
    storageBucket: 'bitel-ventas-9cd08.appspot.com',
    iosClientId: '687680612219-6kfbnjg7p9cq81d7frsl684e10topkpn.apps.googleusercontent.com',
    iosBundleId: 'com.bitel.bss.viettelpos.v3.bitelVentas',
  );
}
