import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/main_screen.dart';
import 'config/theme.dart';
import 'config/routes.dart';
import 'config/provider_setup.dart';
import 'config/localization.dart';
import 'helpers/db_helper.dart' show databaseInit;
import './helpers/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

// Setup app
class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
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
  bool isFirstTime;

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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await databaseInit();
    theme = await getThemeData();
    locale = await initLocale();
    bool firstTime = await getSetting<bool>('firstTime') ?? true;
    if (firstTime) {
      setSetting<bool>('firstTime', false);
    }
    isFirstTime = firstTime;
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
                title: 'Fabrics',
                debugShowCheckedModeBanner: false,
                theme: theme,
                home: MainScreen(),
                localizationsDelegates: localizationsDelegates,
                supportedLocales: supportedLocales,
                locale: locale,
                routes: rootRoutes,
                initialRoute: isFirstTime ? '/firstTime' : '/',
              ),
            )
          : Container(
              color: Colors.black,
              child: Center(
                child: Text(
                  'Fabrics',
                  textScaleFactor: 2,
                  textDirection: TextDirection.ltr,
                ),
              ),
            ),
    );
  }
}
