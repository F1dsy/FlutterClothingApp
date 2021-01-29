import 'package:flutter/material.dart';

class FirstTimeScreen extends StatelessWidget {
  static const routeName = '/firstTime';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
              Color(0xFF675EC7),
              Color(0xFF4239A5),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Welcome',
              textScaleFactor: 3,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              '''This is your own Virtual Closest.
You can take pictures of your clothes,
put them together as outfits and organize
everything about our style.''',
              textAlign: TextAlign.center,
              textScaleFactor: 1.1,
              style: TextStyle(color: Colors.white),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.white70,
              minWidth: 260,
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Text('Continue', textScaleFactor: 1.4),
            )
          ],
        ),
      ),
    );
  }
}
