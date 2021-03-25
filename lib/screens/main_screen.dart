import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
// import '../widgets/navigation/bottom_navigation.dart';

import './settings/settings_screen.dart';

import '../config/routes.dart';

import '../icons/icon.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedIndex = 1;

  // void _selectTab(i) {
  //   setState(() {
  //     _selectedIndex = i;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //Tells which Navigator is active and should react on Back button

    return WillPopScope(
      onWillPop: () async {
        final result = await keys[_selectedIndex].currentState!.maybePop();
        return !result;
      },
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          // selectedIconTheme:
          // Theme.of(context).bottomNavigationBarTheme.selectedIconTheme,
          // selectedLabelStyle:
          // Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
          items: [
            BottomNavigationBarItem(
                icon: Icon(CustomIcons.outfit),
                label: AppLocalizations.of(context)!.outfitsTab),
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.shirt),
              label: AppLocalizations.of(context)!.itemsTab,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: AppLocalizations.of(context)!.calendar,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: AppLocalizations.of(context)!.settings,
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (i) {
            setState(() {
              if (i == 3) {
                Navigator.of(context).pushNamed(SettingsScreen.routeName);
              } else {
                _selectedIndex = i;
              }
            });
          },
        ),
        // Custom Buttom Navigation for future tabs
        // BottomNav(
        //   index: _selectedIndex,
        //   onTap: (i) => _selectTab(i),
        //   navItems: [
        //     BottomNavItem(
        //       icon: CustomIcons.outfit,
        //       label: AppLocalizations.of(context).outfitsTab,
        //     ),
        //     BottomNavItem(
        //       icon: CustomIcons.shirt,
        //       label: AppLocalizations.of(context).itemsTab,
        //     ),
        //     BottomNavItem(
        //       icon: Icons.calendar_today,
        //       label: AppLocalizations.of(context).calendar,
        //     ),
        //   ],
        //   extendedNavItems: [
        //     BottomExtendedNavItem(
        //       icon: Icons.shopping_basket,
        //       label: AppLocalizations.of(context).washBasket,
        //       onTap: () =>
        //           Navigator.of(context).pushNamed(WashBasketScreen.routeName),
        //     ),
        //     BottomExtendedNavItem(
        //       icon: Icons.settings,
        //       label: AppLocalizations.of(context).settings,
        //       onTap: () =>
        //           Navigator.of(context).pushNamed(SettingsScreen.routeName),
        //     ),
        //     BottomExtendedNavItem(
        //       icon: Icons.bar_chart,
        //       label: AppLocalizations.of(context).statistics,
        //       onTap: () {},
        //     ),
        //   ],
        // ),
        body: IndexedStack(
          index: _selectedIndex,
          children: routeNavigators,
        ),
      ),
    );
  }
}
