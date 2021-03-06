import 'package:darookhane/app/core/themes/colors.dart';
import 'package:darookhane/app/core/values/screen_values.dart';
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
          // colorScheme: const ColorScheme(
          //     brightness: Brightness.light,
          //     primary: kColorPrimary,
          //     onPrimary: Colors.white,
          //     secondary: Colors.red,
          //     onSecondary: const Color.fromARGB(0, 7, 86, 221),
          //     error: Colors.red,
          //     onError: Colors.red,
          //     background: const Color.fromARGB(0, 7, 86, 221),
          //     onBackground: Color.fromARGB(0, 7, 86, 221),
          //     surface: const Color.fromARGB(0, 7, 86, 221),
          //     onSurface: Colors.red),
          primaryColor: kColorPrimary,

          // colorSchemeSeed: Colors.red,
          fontFamily: 'Kalameh',
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              color: kColorPrimary,
            ),
            titleLarge: TextStyle(
                color: Colors.black, fontSize: 33, fontWeight: FontWeight.bold),
          ),
          hintColor: kColorHint,
          scaffoldBackgroundColor: kColorFill,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(const TextStyle(
                      fontFamily: 'Kalameh',
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(kBorderRadiusVal))),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.all(20)))),
          inputDecorationTheme: const InputDecorationTheme(
              fillColor: Colors.white,
              floatingLabelStyle: TextStyle(color: kColorInputLabel),
              filled: true,
              isDense: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius:
                      BorderRadius.all(Radius.circular(kBorderRadiusVal)))),
          listTileTheme: ListTileThemeData(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)))),
    ),
  );
}

Future<void> initHive() async {
  await Hive.initFlutter();
  // Hive.registerAdapter(PatientAdapter());
  // Hive.registerAdapter(PersonAdapter());
  // Hive.registerAdapter(GenderAdapter());
}
