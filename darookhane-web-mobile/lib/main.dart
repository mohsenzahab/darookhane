import 'package:darookhane/app/core/themes/colors.dart';
import 'package:darookhane/app/data/enums/gender.dart';
import 'package:darookhane/app/data/models/patient.dart';
import 'package:darookhane/app/data/models/person.dart';
import 'package:darookhane/app/data/provider/locale_db.dart';
import 'package:darookhane/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await initHive();
  bool userSignedIn = (await DB.db.getLoggedInUserToken()) != null;
  String? initialRoute = userSignedIn ? Routes.HOME : Routes.SIGNUP;
  runApp(
    GetMaterialApp(
      title: "Darookane",
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      translationsKeys: AppTranslation.translations,
      locale: const Locale('fa', 'IR'),
      fallbackLocale: const Locale('fa', 'IR'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fa', 'IR'),
      ],
      theme: ThemeData(
          hintColor: Colors.grey,
          scaffoldBackgroundColor: Colors.grey.shade100,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.all(20)))),
          inputDecorationTheme: InputDecorationTheme(
              fillColor: kFilledColor,
              filled: true,
              isDense: true,
              border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(12))))),
    ),
  );
}

Future<void> initHive() async {
  await Hive.initFlutter();
  // Hive.registerAdapter(PatientAdapter());
  // Hive.registerAdapter(PersonAdapter());
  // Hive.registerAdapter(GenderAdapter());
}
