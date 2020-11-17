import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/main_screen.dart';
import './providers/item_categories.dart';
import './providers/items.dart';
import './providers/outfits.dart';
import './providers/outfit_categories.dart';

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
      ),
    );
  }
}
