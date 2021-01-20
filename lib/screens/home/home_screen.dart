import 'dart:ui';

import 'package:flutter/material.dart';

import '../../widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/images/test.jpg',
              fit: BoxFit.fill,
            ),
          ),
          ListView.builder(
            itemCount: 10,
            itemBuilder: (context, i) => Container(
              // height: 120,
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white24,
                    ),
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Test',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
