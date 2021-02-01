import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  Background({this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
              Color(0xFF9C27B0),
              Color(0xFF673AB7),
            ],
          ),
        ),
        child: child,
      ),
    );
  }
}
