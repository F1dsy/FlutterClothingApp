import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../screens/wash/wash_basket_screen.dart';
import '../screens/settings/settings_screen.dart';

void showDrawer(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.only(
    //     topLeft: Radius.circular(15),
    //     topRight: Radius.circular(15),
    // ),
    // ),
    context: context,
    builder: (context) => _DrawerWidget(),
  );
}

class _DrawerWidget extends StatelessWidget {
  void navigate(BuildContext context, String route) {
    Navigator.of(context)
        .pushNamed(route)
        .then((_) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  // width: MediaQuery.of(context).size.width / 3,
                  child: InkWell(
                    onTap: () => navigate(context, WashBasketScreen.routeName),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_basket),
                        Text(AppLocalizations.of(context).washBasket),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  // width: MediaQuery.of(context).size.width / 3,
                  child: InkWell(
                    onTap: () => navigate(context, SettingsScreen.routeName),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings),
                        Text(AppLocalizations.of(context).settings),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  // width: MediaQuery.of(context).size.width / 3,
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bar_chart),
                        Text(AppLocalizations.of(context).statistics),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
