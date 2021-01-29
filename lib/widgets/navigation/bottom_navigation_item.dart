import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final Function onTap;
  NavItem({this.icon, this.label, this.selected, this.onTap});
  @override
  Widget build(BuildContext context) {
    BottomNavigationBarThemeData theme =
        Theme.of(context).bottomNavigationBarTheme;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          height: 43,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconTheme(
                data: selected
                    ? theme.selectedIconTheme
                    : theme.unselectedIconTheme,
                child: Icon(
                  icon,
                ),
              ),
              AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 100),
                style: selected
                    ? theme.selectedLabelStyle
                    : theme.unselectedLabelStyle,
                child: Text(
                  label,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
