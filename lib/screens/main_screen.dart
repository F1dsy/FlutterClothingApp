import 'package:FlutterClothingApp/screens/calendar/calendar_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/drawer.dart';
import '../l10n/app_localizations.dart';
import 'outfits/outfits_category_screen.dart';
import 'outfits/outfits_screen.dart';
import 'items/items_category_screen.dart';
import 'items/items_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<GlobalKey<NavigatorState>> _keys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  var _selectedIndex = 2;

  openBottomNav(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return DrawerWidget();
      },
    );
  }

  void _selectTab(i) {
    setState(() {
      if (i == 4) {
        openBottomNav(context);
      } else {
        _selectedIndex = i;
      }
    });
  }

  BuildNavigator outfitsNav;
  BuildNavigator itemsNav;
  BuildNavigator calendarNav;
  BuildNavigator calendarNav2;

  @override
  void dispose() {
    print('Disposed MainScreen');
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // Provider.of<Items>(context, listen: false).fetchAndSetItems();

    outfitsNav = BuildNavigator({
      OutfitsCategoriesScreen.routeName: (context) => OutfitsCategoriesScreen(),
      OutfitsScreen.routeName: (context) => OutfitsScreen(),
    }, _keys[0]);
    itemsNav = BuildNavigator({
      ItemsCategoriesScreen.routeName: (context) => ItemsCategoriesScreen(),
      ItemsScreen.routeName: (context) => ItemsScreen(),
    }, _keys[1]);
    calendarNav = BuildNavigator({
      CalendarScreen.routeName: (context) => CalendarScreen(),
    }, _keys[2]);
    calendarNav2 = BuildNavigator({
      CalendarScreen.routeName: (context) => CalendarScreen(),
    }, _keys[3]);

    super.didChangeDependencies();
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
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.all_inbox),
                label: AppLocalizations.of(context).outfitsTab,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.subscriptions),
                label: AppLocalizations.of(context).itemsTab,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: AppLocalizations.of(context).home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.calendar_today),
                label: AppLocalizations.of(context).calendar,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Menu',
              ),
            ],
            onTap: (i) => _selectTab(i),
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
          ),
          body: IndexedStack(
            index: _selectedIndex,
            children: [
              outfitsNav,
              itemsNav,
              calendarNav,
              calendarNav2,
              // BuildNavigator({
              //   OutfitsCategoriesScreen.routeName: (context) =>
              //       OutfitsCategoriesScreen(),
              //   OutfitsScreen.routeName: (context) => OutfitsScreen(),
              // }, _keys[0]),
              // BuildNavigator({
              //   ItemsCategoriesScreen.routeName: (context) =>
              //       ItemsCategoriesScreen(),
              //   ItemsScreen.routeName: (context) => ItemsScreen(),
              // }, _keys[1]),

              // BuildNavigator({
              //   CalendarScreen.routeName: (context) => CalendarScreen(),
              // }, _keys[2]),
              // BuildNavigator({
              //   CalendarScreen.routeName: (context) => CalendarScreen(),
              // }, _keys[3]),
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
