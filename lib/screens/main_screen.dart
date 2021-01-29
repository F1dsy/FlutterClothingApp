import 'package:flutter/material.dart';

// import '../widgets/drawer.dart';
import '../l10n/app_localizations.dart';
import '../widgets/navigation/bottom_navigation.dart';
import './wash/wash_basket_screen.dart';
import './settings/settings_screen.dart';

import '../config/routes.dart';

import '../icons/icon.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _selectedIndex = 1;

  void _selectTab(i) {
    setState(() {
      _selectedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Tells which Navigator is active and should react on Back button

    return WillPopScope(
      onWillPop: () async {
        final result = await keys[_selectedIndex].currentState.maybePop();
        return !result;
      },
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: BottomNav(
          index: _selectedIndex,
          onTap: (i) => _selectTab(i),
          navItems: [
            BottomNavItem(
              icon: CustomIcons.outfit,
              label: AppLocalizations.of(context).outfitsTab,
            ),
            BottomNavItem(
              icon: CustomIcons.shirt,
              label: AppLocalizations.of(context).itemsTab,
            ),
            BottomNavItem(
              icon: Icons.home,
              label: 'Home',
            ),
            BottomNavItem(
              icon: Icons.calendar_today,
              label: AppLocalizations.of(context).calendar,
            ),
          ],
          extendedNavItems: [
            BottomExtendedNavItem(
              icon: Icons.shopping_basket,
              label: AppLocalizations.of(context).washBasket,
              onTap: () =>
                  Navigator.of(context).pushNamed(WashBasketScreen.routeName),
            ),
            BottomExtendedNavItem(
              icon: Icons.settings,
              label: AppLocalizations.of(context).settings,
              onTap: () =>
                  Navigator.of(context).pushNamed(SettingsScreen.routeName),
            ),
            BottomExtendedNavItem(
              icon: Icons.bar_chart,
              label: AppLocalizations.of(context).statistics,
              onTap: () {},
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: routeNavigators,
        ),
      ),
    );
  }
}
