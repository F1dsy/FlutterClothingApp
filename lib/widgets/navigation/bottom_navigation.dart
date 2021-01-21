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
      builder: (context, child) => Container(
        height: _heightAnimation.value * 150 + 77,
        decoration: ShapeDecoration(
            shape: _ArcShape(
                _animationController.status == AnimationStatus.forward
                    ? _borderAnimationForward.value
                    : _borderAnimationReverse.value),
            color: Theme.of(context).primaryColor,
            shadows: [BoxShadow()]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
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
            Expanded(
              child: Row(
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
            child
          ],
        ),
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

// class _ArcClipper extends CustomClipper<Path> {
//   final double _animation;
//   _ArcClipper(this._animation);
//   @override
//   Path getClip(Size size) {
//     Path path = Path();

//     path.moveTo(0, size.height);
//     path.lineTo(0, 20 + _animation);
//     path.quadraticBezierTo(
//       size.width / 2,
//       -20 - _animation,
//       size.width,
//       20 + _animation,
//     );
//     path.lineTo(size.width, size.height);

//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper old) => false;
// }

class _ArcShape extends ShapeBorder {
  final double _animation;
  _ArcShape(this._animation);
  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return getOuterPath(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path path = Path();

    path.moveTo(0, rect.bottomLeft.dy);
    path.lineTo(0, rect.topLeft.dy + 20 + _animation);
    path.quadraticBezierTo(
      rect.width / 2,
      rect.topLeft.dy - 20 - _animation,
      rect.width,
      rect.topLeft.dy + 20 + _animation,
    );
    path.lineTo(rect.width, rect.topLeft.dy + rect.height);

    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) => _ArcShape(_animation);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(0);
}
