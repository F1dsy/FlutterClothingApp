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
import 'screens/outfits/outfit_builder.dart';
import 'screens/items/add_item_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Locale _locale = Locale('de');
  @override
  // void didChangeDependencies() {
  //   SharedPreferences.getInstance().then((pref) {
  //     String string = pref.getString('language');
  //     setState(() {
  //       _locale = Locale(string);
  //       _locale = Provider.of<LangProvider>(context).locale;
  //     });
  //   });
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ItemCategories()),
        ChangeNotifierProvider(create: (context) => Items()),
        ChangeNotifierProvider(create: (context) => OutfitCategories()),
        ChangeNotifierProvider(create: (context) => Outfits()),
        ChangeNotifierProvider(create: (context) => LangProvider()),
      ],
      builder: (context, _) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: Colors.deepPurple,
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
        locale: Provider.of<LangProvider>(context).locale,
        routes: {
          OutfitBuilder.routeName: (context) => OutfitBuilder(),
          AddItemScreen.routeName: (context) => AddItemScreen(),
          WashBasketScreen.routeName: (context) => WashBasketScreen(),
          SettingsScreen.routeName: (context) => SettingsScreen(),
        },
      ),
    );
  }
}

class LangProvider extends ChangeNotifier {
  Locale locale = Locale('en');

  LangProvider() {
    SharedPreferences.getInstance().then((pref) {
      String string = pref.getString('language');

      locale = Locale(string);
      notifyListeners();
    });
  }

  void changeLocale(Locale local) async {
    locale = local;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('language', local.countryCode);
    notifyListeners();
  }
}
