import 'package:flutter/material.dart';

final theme = ThemeData(
  // primarySwatch: Colors.purple,
  primaryColor: Color(0xFF342D7E),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  accentColor: Color(0xFF4239A5),
  canvasColor: Color(0xFFFEFEFE),
  appBarTheme: AppBarTheme(
    shadowColor: Colors.black,
    // color: Colors.grey,

    centerTitle: true,
    actionsIconTheme: IconThemeData(color: Colors.white),
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      headline6: TextStyle().copyWith(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.normal),
    ),
  ),
);
