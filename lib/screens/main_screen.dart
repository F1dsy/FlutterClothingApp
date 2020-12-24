// import 'package:FlutterClothingApp/widgets/drawer.dart';
import '../widgets/drawer.dart';
import 'package:flutter/material.dart';

import 'items/items_category_screen.dart';
import 'outfits/outfits_category_screen.dart';
import 'items/items_screen.dart';

import 'outfits/outfits_screen.dart';

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

  openBottomNav(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DrawerWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //Tells which Navigator is active and should react on Back button
    return WillPopScope(
      onWillPop: () async {
        final result = await _keys[_selectedIndex].currentState.maybePop();
        return !result;
      },
      child: Scaffold(
          // drawer: SafeArea(
          //   child: DrawerWidget(),
          // ),
          // appBar: AppBar(),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.all_inbox),
                label: 'Outfits',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.subscriptions),
                label: 'Items',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Menu',
              ),
            ],
            onTap: (i) {
              setState(() {
                if (i == 4) {
                  openBottomNav(context);
                } else {
                  _selectedIndex = i;
                }
              });
            },
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
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
