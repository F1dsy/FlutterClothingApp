import 'package:flutter/material.dart';
import '../helpers/shared_preferences.dart';

Future<ThemeData> getThemeData() {
  return getSetting<String>('colorTheme').then((theme) {
    if (theme == 'light') {
      return themeLight;
    } else {
      return themeDark;
    }
  });
}

final themeLight = ThemeData(
  primaryColor: Color(0xFF342D7E),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  accentColor: Color(0xFF4239A5),
  canvasColor: Color(0xFFF2F2F2),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    actionsIconTheme: IconThemeData(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      headline6: TextStyle().copyWith(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.normal),
    ),
  ),
);

final themeDark = ThemeData(
  primarySwatch: Colors.purple,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  accentColor: Color(0xFF4239A5),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    actionsIconTheme: IconThemeData(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      headline6: TextStyle().copyWith(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.normal),
    ),
  ),
);
