import 'package:flutter/material.dart';

import 'items_category_screen.dart';
import 'outfits_screen.dart';
import 'item_screen.dart';
import 'add_item_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // List<Widget> _pages = [
  //   BuildNavigator({
  //     '/': (context) => OutfitsScreen(),
  //   }),
  //   BuildNavigator({
  //     '/': (context) => ItemsCategoriesScreen(),
  //     '/item': (context) => ItemsScreen(),
  //     '/newCategory': (context) => AddItemCategoryScreen(),
  //     '/newItem': (context) => AddItemScreen()
  //   }),
  // ];

  List<GlobalKey<NavigatorState>> _keys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  var _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final result = await _keys[_selectedIndex].currentState.maybePop();
        return !result;
      },
      child: Scaffold(

          // appBar: _pageAppbars[_selectedIndex],
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
          body: IndexedStack(
            index: _selectedIndex,
            children: [
              BuildNavigator({
                '/': (context) => OutfitsScreen(),
              }, _keys[0]),
              BuildNavigator({
                '/': (context) => ItemsCategoriesScreen(),
                '/item': (context) => ItemsScreen(),
                '/newItem': (context) => AddItemScreen()
              }, _keys[1]),
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
