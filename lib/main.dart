import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:emarsys_sdk/emarsys_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flex_storefront/app.dart';
import 'package:flex_storefront/config/config_repository.dart';
import 'package:flex_storefront/init.dart';
import 'package:flex_storefront/shared/bloc_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:get_it/get_it.dart';
import 'package:loggy/loggy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  Loggy.initLoggy(
    logPrinter: const PrettyDeveloperPrinter(),
  );

  await Firebase.initializeApp();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    Loggy('CrashlyticsLoggy').error(
      'Unhandled error sent to Crashlytics',
      error,
      stack,
    );

    FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
      printDetails: false,
    );

    return true;
  };

  // Allow all network requests, temporarily for local hybris instance over https
  // TODO: Remove when hybris moves to cloud instance
  // https://stackoverflow.com/questions/61411580/flutter-web-http-request-badcertificatecallback
  // HttpOverrides.global = MyHttpOverrides();

  Emarsys.setup(EmarsysConfig(applicationCode: dotenv.get('EMARSYS_APP_CODE')));

  Bloc.observer = BlocLogger();

  init();

  await GetIt.instance.allReady();

  unawaited(GetIt.instance.get<ConfigRepository>().fetch());

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
