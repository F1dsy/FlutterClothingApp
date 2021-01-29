import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/main_screen.dart';
import 'config/theme.dart';
import 'config/routes.dart';
import 'config/provider_setup.dart';
import 'config/localization.dart';
import 'helpers/db_helper.dart' show databaseInit;

void main() {
  runApp(MyApp());
}

// Setup app
class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state._setLocale(newLocale);
  }

  static void setColorTheme(BuildContext context) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state._setTheme();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale locale;
  Future initFuture;
  ThemeData theme;

  void _setLocale(Locale local) {
    setState(() {
      locale = local;
    });
  }

  void _setTheme() async {
    theme = await getThemeData();
    setState(() {});
  }

  Future<void> init() async {
    await databaseInit();
    theme = await getThemeData();
    locale = await initLocale();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int washThreshold = preferences.getInt('washThreshold');
    if (washThreshold == null) {
      preferences.setInt('washThreshold', 3);
    }
  }

  @override
  void initState() {
    initFuture = init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initFuture,
      builder: (context, snap) => snap.connectionState == ConnectionState.done
          ? ProviderSetup(
              child: MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: theme,
                home: MainScreen(),
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                locale: locale,
                routes: rootRoutes,
              ),
            )
          : Container(),
    );
  }
}
