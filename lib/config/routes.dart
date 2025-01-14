import 'package:flutter/material.dart';
// import 'package:path/path.dart';

import '../screens/settings/settings_screen.dart';
import '../screens/outfits/outfit_builder.dart';
// import '../screens/items/add_item_screen.dart';
import '../screens/outfits/outfits_category_screen.dart';
import '../screens/outfits/outfits_screen.dart';
import '../screens/items/items_category_screen.dart';
import '../screens/items/items_screen.dart';
import '../screens/items/move_item.dart';
import '../screens/calendar/calendar_screen.dart';
import '../screens/calendar/add_event_screen.dart';
import '../screens/first_time/first_time_screen.dart';
import '../screens/items/item_screen.dart';

import '../screens/home/home_screen.dart';

final Map<String, WidgetBuilder> rootRoutes = {
  OutfitBuilder.routeName: (context) => OutfitBuilder(),
  // AddItemScreen.routeName: (context) => AddItemScreen(),
  SettingsScreen.routeName: (context) => SettingsScreen(),
  AddEventScreen.routeName: (context) => AddEventScreen(),
  FirstTimeScreen.routeName: (context) => FirstTimeScreen(),
  ItemScreen.routeName: (context) => ItemScreen(),
  ItemScreen.routeNameAddItem: (context) => ItemScreen(),
};

List<GlobalKey<NavigatorState>> keys = [
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
];

List<Widget> routeNavigators = [
  BuildNavigator({
    OutfitsCategoriesScreen.routeName: (context) => OutfitsCategoriesScreen(),
    OutfitsScreen.routeName: (context) => OutfitsScreen(),
  }, keys[0]),
  BuildNavigator({
    ItemsCategoriesScreen.routeName: (context) => ItemsCategoriesScreen(),
    ItemsScreen.routeName: (context) => ItemsScreen(),
    MoveItem.routeName: (context) => MoveItem(),
  }, keys[1]),
  BuildNavigator({
    CalendarScreen.routeName: (context) => CalendarScreen(),
  }, keys[2]),
  BuildNavigator({
    HomeScreen.routeName: (context) => HomeScreen(),
  }, keys[3])
];

class BuildNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> _key;
  final Map<String, WidgetBuilder> _routes;

  BuildNavigator(this._routes, this._key);
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _key,
      initialRoute: '/',
      onGenerateRoute: (settings) => MaterialPageRoute(
          builder: _routes[settings.name!]!, settings: settings),
    );
  }
}
