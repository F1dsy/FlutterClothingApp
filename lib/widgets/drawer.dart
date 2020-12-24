import 'package:flutter/material.dart';

import '../screens/wash/wash_basket_screen.dart';

class DrawerWidget extends StatelessWidget {
  void navigate(BuildContext context, String route) {
    Navigator.of(context)
        .pushNamed(route)
        .then((_) => Navigator.of(context).pop());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width / 3,
                child: InkWell(
                  onTap: () => navigate(context, WashBasketScreen.routeName),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_basket),
                      Text('Wash'),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width / 3,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.settings),
                      Text('Settings'),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width / 3,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bar_chart),
                      Text('Statistics'),
                    ],
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
