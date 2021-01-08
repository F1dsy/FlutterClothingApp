import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/app_localizations.dart';
import './screens/settings/settings_screen.dart';
import './screens/wash/wash_basket_screen.dart';
import './screens/main_screen.dart';
import './providers/item_categories.dart';
import './providers/items.dart';
import './providers/outfits.dart';
import './providers/outfit_categories.dart';
import './providers/events.dart';
import 'screens/outfits/outfit_builder.dart';
import 'screens/items/add_item_screen.dart';
import 'screens/calendar/add_event_screen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ItemCategories()..fetchAndSetCategories(),
          // lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => Items()..fetchAndSetItems(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => OutfitCategories()..fetchAndSetCategories(),
          // lazy: false,
        ),
        ChangeNotifierProxyProvider<Items, Outfits>(
          create: (context) => Outfits(),
          update: (context, items, outfits) => outfits..update = items.items,
          // lazy: false,
        ),
        ChangeNotifierProxyProvider<Outfits, Events>(
          create: (context) => Events(),
          update: (context, outfits, events) =>
              events..update = outfits.outfits,
          // lazy: false,
        ),
      ],
      builder: (context, _) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: Colors.tealAccent,
          // brightness: Brightness.dark,
        ),
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
        routes: {
          OutfitBuilder.routeName: (context) => OutfitBuilder(),
          AddItemScreen.routeName: (context) => AddItemScreen(),
          AddEventScreen.routeName: (context) => AddEventScreen(),
          WashBasketScreen.routeName: (context) => WashBasketScreen(),
          SettingsScreen.routeName: (context) => SettingsScreen(),
        },
      ),
    );
  }
}
