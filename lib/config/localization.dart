import 'dart:io' show Platform;

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:FlutterClothingApp/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localizationsDelegates = [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

final supportedLocales = [
  const Locale('en'),
  const Locale('de'),
  const Locale('da'),
];

Locale getLocale() {
  String locString = Platform.localeName;
  return Locale(locString.substring(0, 2));
}

Future<Locale> initLocale() async {
  // initialize locale shared preferences. If first time, set standart values
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String string = preferences.getString('language');

  if (string == null) {
    Locale locale = getLocale();
    if (supportedLocales.contains(locale)) {
      preferences.setString('language', locale.languageCode);
      return locale;
    } else {
      preferences.setString('language', 'en');
      return Locale('en');
    }
  }
  return Locale(string);
}
