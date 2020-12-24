import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ItemCategories()),
        ChangeNotifierProvider(create: (context) => Items()),
        ChangeNotifierProvider(create: (context) => OutfitCategories()),
        ChangeNotifierProvider(create: (context) => Outfits()),
      ],
      child: MaterialApp(
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
        locale: Locale('da'),
        routes: {
          OutfitBuilder.routeName: (context) => OutfitBuilder(),
          AddItemScreen.routeName: (context) => AddItemScreen(),
          WashBasketScreen.routeName: (context) => WashBasketScreen(),
        },
      ),
    );
  }
}
