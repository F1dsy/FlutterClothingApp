import 'package:flutter/material.dart';

class BoxOutline extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;

  BoxOutline({
    this.child,
    this.height = 220,
    this.width = 220,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        border: Border.all(color: Colors.white54, width: 10),
      ),
      child: child,
    );
  }
}
