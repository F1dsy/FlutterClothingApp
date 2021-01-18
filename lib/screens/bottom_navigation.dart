import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class BottomNav extends StatefulWidget {
  final int currentIndex;
  final Function onTap;
  BottomNav(this.currentIndex, this.onTap(int));

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
      duration: Duration(milliseconds: 500),
    );
    _heightAnimation = CurvedAnimation(
      curve: Curves.ease,
      parent: _animationController,
    );
    _borderAnimationForward = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 40), weight: 25),
      TweenSequenceItem(tween: Tween<double>(begin: 40, end: 0), weight: 75),
    ]).animate(_animationController);
    _borderAnimationReverse = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: -40), weight: 25),
      TweenSequenceItem(tween: Tween<double>(begin: -40, end: 0), weight: 75),
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
      builder: (context, _) => Container(
        height: _heightAnimation.value * 170 + 80,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.elliptical(
              300,
              _animationController.status == AnimationStatus.forward
                  ? _borderAnimationForward.value + 40
                  : _borderAnimationReverse.value + 40,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onVerticalDragStart: (_) {
                setState(() {
                  open
                      ? _animationController.forward()
                      : _animationController.reverse();
                  open = !open;
                });
              },
              onTap: () {
                setState(() {
                  open
                      ? _animationController.forward()
                      : _animationController.reverse();
                  open = !open;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 7,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
              ),
            ),
            // open
            //     ? Container(
            //         child: Row(
            //           children: [
            //             NavItem(
            //               icon: Icons.shopping_basket,
            //               label: AppLocalizations.of(context).outfitsTab,
            //               selected: widget.currentIndex == 0,
            //               onTap: () => widget.onTap(0),
            //             ),
            //             NavItem(
            //               icon: Icons.settings,
            //               label: AppLocalizations.of(context).outfitsTab,
            //               selected: widget.currentIndex == 0,
            //               onTap: () => widget.onTap(0),
            //             ),
            //             NavItem(
            //               icon: Icons.bar_chart,
            //               label: AppLocalizations.of(context).outfitsTab,
            //               selected: widget.currentIndex == 0,
            //               onTap: () => widget.onTap(0),
            //             ),
            //           ],
            //         ),
            //       )
            //     : Container(),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavItem(
                    icon: Icons.all_inbox,
                    label: AppLocalizations.of(context).outfitsTab,
                    selected: widget.currentIndex == 0,
                    onTap: () => widget.onTap(0),
                  ),
                  NavItem(
                    icon: Icons.subscriptions,
                    label: AppLocalizations.of(context).itemsTab,
                    selected: widget.currentIndex == 1,
                    onTap: () => widget.onTap(1),
                  ),
                  NavItem(
                    icon: Icons.calendar_today,
                    label: AppLocalizations.of(context).calendar,
                    selected: widget.currentIndex == 2,
                    onTap: () => widget.onTap(2),
                  ),
                  NavItem(
                    icon: Icons.menu,
                    label: 'Menu',
                    selected: widget.currentIndex == 3,
                    onTap: () => widget.onTap(3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
