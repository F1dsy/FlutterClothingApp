import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final bool? selected;
  final Function? onTap;
  NavItem({this.icon, this.label, this.selected, this.onTap});

  Widget buildChild(theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconTheme(
          data: selected! ? theme.selectedIconTheme : theme.unselectedIconTheme,
          child: Icon(
            icon,
          ),
        ),
        SizedBox(
          height: 2,
        ),
        AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 100),
          style:
              selected! ? theme.selectedLabelStyle : theme.unselectedLabelStyle,
          child: Text(
            label!,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarThemeData theme =
        Theme.of(context).bottomNavigationBarTheme;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap as void Function()?,
        child: Container(
          height: 50,
          child:
              // selected
              // ? ShaderMask(
              //     shaderCallback: (rect) => LinearGradient(
              //       // begin: Alignment.topLeft,
              //       // end: Alignment.topCenter,
              //       colors: [Colors.purple, Colors.deepPurple],
              //     ).createShader(rect),
              //     child: buildChild(theme),
              //   )
              // :
              buildChild(theme),
        ),
      ),
    );
  }
}
