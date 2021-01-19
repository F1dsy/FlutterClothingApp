import 'package:flutter/material.dart';

final theme = ThemeData(
  primarySwatch: Colors.teal,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  accentColor: Colors.tealAccent,
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
