import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/main_screen.dart';
import 'config/theme.dart';
import 'config/routes.dart';
import 'config/provider_setup.dart';
import 'config/localization.dart';
import 'helpers/db_helper.dart' show databaseInit;

void main() {
  runApp(Init());
}

// Initialize database and show splashscreen(future)
class Init extends StatelessWidget {
  Future<void> init() async {
    await databaseInit();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int washThreshold = preferences.getInt('washThreshold');
    if (washThreshold == null) {
      preferences.setInt('washThreshold', 3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }
        return Container();
      },
    );
  }
}

// Setup app
class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state._setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void _setLocale(Locale local) {
    setState(() {
      _locale = local;
    });
  }

  @override
  void didChangeDependencies() async {
    _locale = await initLocale();
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
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        locale: _locale,
        routes: rootRoutes,
      ),
    );
  }
}
