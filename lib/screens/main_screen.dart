import 'package:flutter/material.dart';

import 'items_category_screen.dart';
import 'outfits_category_screen.dart';
import 'items_screen.dart';
import 'add_item_screen.dart';
import 'outfits_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<GlobalKey<NavigatorState>> _keys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  var _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    //Tells which Navigator is active and should react on Back button
    return WillPopScope(
      onWillPop: () async {
        final result = await _keys[_selectedIndex].currentState.maybePop();
        return !result;
      },
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.all_inbox),
                label: 'Outfits',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.subscriptions),
                label: 'Items',
              )
            ],
            onTap: (i) {
              setState(() {
                _selectedIndex = i;
              });
            },
            currentIndex: _selectedIndex,
          ),
          body: Stack(
            children: [
              Offstage(
                offstage: _selectedIndex != 0,
                child: BuildNavigator({
                  OutfitsCategoriesScreen.routeName: (context) =>
                      OutfitsCategoriesScreen(),
                  OutfitsScreen.routeName: (context) => OutfitsScreen(),
                }, _keys[0]),
              ),
              Offstage(
                offstage: _selectedIndex != 1,
                child: BuildNavigator({
                  ItemsCategoriesScreen.routeName: (context) =>
                      ItemsCategoriesScreen(),
                  ItemsScreen.routeName: (context) => ItemsScreen(),
                  AddItemScreen.routeName: (context) => AddItemScreen()
                }, _keys[1]),
              ),
            ],
          )),
    );
  }
}

class BuildNavigator extends StatelessWidget {
  // final GlobalKey<NavigatorState> _key = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _key;
  final Map<String, WidgetBuilder> _routes;
  BuildNavigator(this._routes, this._key);
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _key,
      initialRoute: '/',
      onGenerateRoute: (settings) => MaterialPageRoute(
          builder: _routes[settings.name], settings: settings),
    );
  }
}
