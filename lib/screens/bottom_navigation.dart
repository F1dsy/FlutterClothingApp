import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function onTap;
  BottomNav(this.currentIndex, this.onTap(int));
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.elliptical(300, 40)),
      child: Container(
        color: Theme.of(context).primaryColor,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 7,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NavItem(
                    icon: const Icon(Icons.all_inbox, color: Colors.white),
                    label: AppLocalizations.of(context).outfitsTab,
                    selected: currentIndex == 0,
                    onTap: () => onTap(0),
                  ),
                  NavItem(
                    icon: const Icon(Icons.subscriptions, color: Colors.white),
                    label: AppLocalizations.of(context).itemsTab,
                    selected: currentIndex == 1,
                    onTap: () => onTap(1),
                  ),
                  NavItem(
                    icon: const Icon(Icons.calendar_today, color: Colors.white),
                    label: AppLocalizations.of(context).calendar,
                    selected: currentIndex == 2,
                    onTap: () => onTap(2),
                  ),
                  NavItem(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    label: 'Menu',
                    selected: currentIndex == 3,
                    onTap: () => onTap(3),
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
  final Icon icon;
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
              icon,
              AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 100),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: !selected ? 12 : 14,
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
