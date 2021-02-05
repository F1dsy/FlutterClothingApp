import 'dart:ui';

import 'package:flutter/material.dart';
import '../helpers/shared_preferences.dart';

Future<ThemeData> getThemeData() {
  return getSetting<String>('colorTheme').then((theme) {
    if (theme == null) {
      setSetting<String>('colorTheme', 'light');
    }
    if (theme == 'dark') {
      return themeDark;
    } else {
      return themeLight;
    }
  });
}

final themeLight = ThemeData(
  primaryColor: Color(0xFF342D7E),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  accentColor: Color(0xFF4239A5),
  canvasColor: Color(0xFFF2F2F2),
  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //   selectedIconTheme: IconThemeData(color: Colors.white),
  //   unselectedIconTheme: IconThemeData(color: Colors.white70),
  //   selectedLabelStyle: TextStyle().copyWith(color: Colors.white, fontSize: 14),
  //   unselectedLabelStyle:
  //       TextStyle().copyWith(color: Colors.white70, fontSize: 12),
  // ),
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
  primarySwatch: Colors.deepPurple,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  brightness: Brightness.dark,
  accentColor: Color(0xFF4239A5),
  toggleableActiveColor: Colors.purple,
  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //   selectedIconTheme:
  //       IconThemeData(color: Colors.deepPurple, opacity: 1, size: 24.0),
  //   unselectedIconTheme:
  //       IconThemeData(color: Colors.white, opacity: 0.7, size: 24.0),
  //   selectedLabelStyle:
  //       TextStyle().copyWith(color: Colors.deepPurple, fontSize: 14),
  //   unselectedLabelStyle:
  //       TextStyle().copyWith(color: Colors.white70, fontSize: 12),
  // ),
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
