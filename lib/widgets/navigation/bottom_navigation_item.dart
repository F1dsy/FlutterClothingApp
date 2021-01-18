import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final Function onTap;
  NavItem({this.icon, this.label, this.selected, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          height: 43,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: selected ? Colors.white : Colors.white70,
              ),
              AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 100),
                style: TextStyle(
                  color: selected ? Colors.white : Colors.white70,
                  fontSize: selected ? 14 : 12,
                ),
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
