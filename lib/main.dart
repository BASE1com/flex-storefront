import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flex_storefront/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  final platform = defaultTargetPlatform.name.toUpperCase(); // ANDROID or IOS
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.get('FIREBASE_${platform}_API_KEY'),
      appId: dotenv.get('FIREBASE_${platform}_APP_ID'),
      messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID'),
      projectId: dotenv.get('FIREBASE_PROJECT_ID'),
      storageBucket: dotenv.get('FIREBASE_STORAGE_BUCKET'),
      iosBundleId: dotenv.get('FIREBASE_IOS_BUNDLE_ID'),
    ),
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Allow all network requests, temporarily for local hybris instance over https
  // TODO: Remove when hybris moves to cloud instance
  // https://stackoverflow.com/questions/61411580/flutter-web-http-request-badcertificatecallback
  HttpOverrides.global = MyHttpOverrides();

  runApp(App());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
