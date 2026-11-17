import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Generated from Firebase project `fir-todo-app-a9fbc` (Firebase-Todo-App).
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
      default:
        return android;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCAK8aGEGCEceAnBMoRVulyC1puQEUx96A',
    appId: '1:226859237139:web:c6e5a4f3b2a10987',
    messagingSenderId: '226859237139',
    projectId: 'fir-todo-app-a9fbc',
    authDomain: 'fir-todo-app-a9fbc.firebaseapp.com',
    storageBucket: 'fir-todo-app-a9fbc.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCAK8aGEGCEceAnBMoRVulyC1puQEUx96A',
    appId: '1:226859237139:android:db72d08c3c8935947264e6',
    messagingSenderId: '226859237139',
    projectId: 'fir-todo-app-a9fbc',
    storageBucket: 'fir-todo-app-a9fbc.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCAK8aGEGCEceAnBMoRVulyC1puQEUx96A',
    appId: '1:226859237139:ios:db72d08c3c8935947264e6',
    messagingSenderId: '226859237139',
    projectId: 'fir-todo-app-a9fbc',
    storageBucket: 'fir-todo-app-a9fbc.firebasestorage.app',
    iosBundleId: 'com.todoapp.firebaseIntegratedTodoApp',
  );
}
