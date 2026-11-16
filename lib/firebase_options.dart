import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyA_placeholder_api_key_web_12345',
    appId: '1:123456789012:web:abcdef1234567890',
    messagingSenderId: '123456789012',
    projectId: 'firebase-todo-app-kuet',
    authDomain: 'firebase-todo-app-kuet.firebaseapp.com',
    storageBucket: 'firebase-todo-app-kuet.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB_placeholder_api_key_android_123',
    appId: '1:123456789012:android:9876543210fedcba',
    messagingSenderId: '123456789012',
    projectId: 'firebase-todo-app-kuet',
    storageBucket: 'firebase-todo-app-kuet.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_placeholder_api_key_ios_12345',
    appId: '1:123456789012:ios:1234567890abcdef',
    messagingSenderId: '123456789012',
    projectId: 'firebase-todo-app-kuet',
    storageBucket: 'firebase-todo-app-kuet.appspot.com',
    iosBundleId: 'com.todoapp.firebaseIntegratedTodoApp',
  );
}
