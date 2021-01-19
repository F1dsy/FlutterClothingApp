import 'package:flutter/material.dart';

import 'bottom_navigation_item.dart';
import 'bottom_navigation_box_item.dart';

class BottomNav extends StatefulWidget {
  final int index;
  final Function onTap;

  final List<BottomNavItem> navItems;
  final List<BottomExtendedNavItem> extendedNavItems;
  BottomNav({
    this.index,
    this.onTap(int index),
    this.navItems,
    this.extendedNavItems,
  });

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav>
    with SingleTickerProviderStateMixin {
  bool open = false;

  AnimationController _animationController;
  Animation _heightAnimation;
  Animation _borderAnimationForward;
  Animation _borderAnimationReverse;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _heightAnimation = CurvedAnimation(
      curve: Curves.ease,
      parent: _animationController,
    );
    _borderAnimationForward = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 30), weight: 25),
      TweenSequenceItem(tween: Tween<double>(begin: 30, end: 0), weight: 75),
    ]).animate(_animationController);
    _borderAnimationReverse = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: -10), weight: 25),
      TweenSequenceItem(tween: Tween<double>(begin: -10, end: 0), weight: 75),
    ]).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: _heightAnimation.value * 140 + 82,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      setState(() {
                        !open
                            ? _animationController.forward()
                            : _animationController.reverse();
                        open = !open;
                      });
                    },
                    child: _MenuIcon(),
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      widget.extendedNavItems.length,
                      (i) => NavBoxItem(
                        animation: _animationController,
                        icon: widget.extendedNavItems[i].icon,
                        label: widget.extendedNavItems[i].label,
                        onTap: widget.extendedNavItems[i].onTap,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 55,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
            child: child,
          ),
        ],
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              widget.navItems.length,
              (i) => NavItem(
                    icon: widget.navItems[i].icon,
                    label: widget.navItems[i].label,
                    selected: i == widget.index,
                    onTap: () => widget.onTap(i),
                  )),
        ),
      ),
    );
  }
}

class _MenuIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 7,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
      ),
    );
  }
}

class BottomNavItem {
  final IconData icon;
  final String label;
  BottomNavItem({this.icon, this.label});
}

class BottomExtendedNavItem {
  final IconData icon;
  final String label;
  final Function onTap;
  BottomExtendedNavItem({this.icon, this.label, this.onTap});
}
