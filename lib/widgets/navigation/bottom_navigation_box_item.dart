import 'package:flutter/material.dart';

class NavBoxItem extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final Function? onTap;
  final Animation? animation;
  NavBoxItem({
    this.icon,
    this.label,
    this.onTap,
    this.animation,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScaleTransition(
        scale: animation!.drive(CurveTween(curve: Curves.ease)),
        child: AspectRatio(
          aspectRatio: 1,
          child: Card(
            margin: EdgeInsets.all(10),
            child: InkWell(
              onTap: onTap as void Function()?,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Icon(
                        icon,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      label!,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
