import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'main/router/route_config.dart';
import 'main/services/location_service.dart';
import 'main/services/settings_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// AWAIT SERVICES INITIALIZATION.
  await initServices();
  await initializeService();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const MyApp());
}

Future initServices() async {
  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  await Get.putAsync(() => SettingService().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: Get.find<SettingService>().getToken()
          ? RouteConfig.main
          : RouteConfig.login,
      // initialRoute:  RouteConfig.main,
      getPages: RouteConfig.getPages,
      locale: Get.find<SettingService>().currentLocate.value,
      supportedLocales: RouteConfig.listLanguage,
      theme: ThemeData(
        dividerColor: Colors.transparent,
      ),
    );
  }
}
