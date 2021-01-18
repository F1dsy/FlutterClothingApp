import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/app_localizations.dart';

import './screens/main_screen.dart';

import 'theme.dart';
import 'routes.dart';
import 'provider_setup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  setLocale(Locale local) {
    setState(() {
      _locale = local;
    });
  }

  @override
  void didChangeDependencies() async {
    // initialize all shared preferences. If first time, set standart values
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String string = preferences.getString('language');
    int washThreshold = preferences.getInt('washThreshold');
    if (string == null) {
      _locale = Locale('en');
      preferences.setString('language', 'en');
    } else {
      _locale = Locale(string);
    }
    if (washThreshold == null) {
      preferences.setInt('washThreshold', 3);
      print('setWash');
    }
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderSetup(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: MainScreen(),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('de'),
          const Locale('da'),
        ],
        locale: _locale,
        routes: rootRoutes,
      ),
    );
  }
}
