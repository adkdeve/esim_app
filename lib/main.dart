import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/core/core.dart';
import 'binding/app_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            title: AppConfig.appName,
            initialBinding: AppBinding(),
            debugShowCheckedModeBanner: false,
            defaultTransition: Transition.rightToLeft,
            // Localization
            translations: MyAppTranslation(),
            locale: AppConfig.defaultLocale,
            fallbackLocale: AppConfig.defaultLocale,
            supportedLocales: MyAppTranslation.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            // Theme
            themeMode: AppConfig.appDefaultTheme,
            theme: R.theme.light,
            darkTheme: R.theme.dark,
            // End
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
          );
        }),
  );
}
