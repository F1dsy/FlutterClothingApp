import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        AppBar(),
        FlatButton.icon(
          onPressed: () {},
          icon: Icon(Icons.settings),
          label: Text('Settings'),
        )
      ],
    ));
  }
}
