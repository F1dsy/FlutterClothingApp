import 'package:flutter/material.dart';

import 'next_button.dart';
import 'outfit_item.dart';
import 'background.dart';

class FourthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Animation animation = ModalRoute.of(context).animation;

    return Background(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: animation
                        .drive(Tween<double>(begin: 207, end: 80).chain(
                            CurveTween(
                                curve: Interval(0, 0.4, curve: Curves.ease))))
                        .value,
                  ),
                  child: OutfitBox(animation: animation),
                ),
              ],
            ),
            NextButton(
              page: PageName.Fifth,
              duration: Duration(seconds: 2),
            ),
          ],
        ),
      ),
    );
  }
}

class OutfitBox extends StatelessWidget {
  final Animation animation;
  OutfitBox({this.animation});

  @override
  Widget build(BuildContext context) {
    Animation height = Tween<double>(begin: 220, end: 380)
        .chain(CurveTween(curve: Interval(0, 0.4, curve: Curves.ease)))
        .animate(animation);
    Animation clumpItems = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Interval(0.4, 0.7, curve: Curves.ease)))
        .animate(animation);
    Animation arrow = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Interval(0.6, 0.9, curve: Curves.ease)))
        .animate(animation);
    Animation outfit = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Interval(0.7, 1, curve: Curves.ease)))
        .animate(animation);

    return Column(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          height: height.value,
          width: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            border: Border.all(color: Colors.white54, width: 10),
          ),
          child: Column(
            children: [
              Clump(clumpItems: clumpItems.value),
              Expanded(
                child: Opacity(
                  opacity: arrow.value,
                  child: Icon(
                    Icons.arrow_downward_rounded,
                    color: Colors.white54,
                    size: 40,
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Opacity(
                  opacity: outfit.value,
                  child: Center(child: OutfitItem()),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 220,
          margin: EdgeInsets.only(top: 20),
          child: Text(
            'Combine your items to elaborate outfits',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(animation.value * 0.7),
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class Clump extends StatelessWidget {
  final double clumpItems;
  Clump({this.clumpItems = 1});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 20,
            left: 20 + (clumpItems ?? 0) * 10,
            child: Container(
              width: 70,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: Colors.white54,
              ),
            ),
          ),
          Positioned(
            // bottom: (clumpItems ?? 0) * 35,
            top: 150 - (clumpItems ?? 0) * 35,
            left: 20 + (clumpItems ?? 0) * 25,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: Colors.white54,
              ),
              width: 70,
              height: 30,
            ),
          ),
          Positioned(
            top: 20 + (clumpItems ?? 0) * 40,
            right: 20 + (clumpItems ?? 0) * 30,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: Colors.white54,
              ),
              width: 70,
              height: 80,
            ),
          ),
          Positioned(
            // bottom: (clumpItems ?? 0) * 15,
            top: 120 - (clumpItems ?? 0) * 15,
            right: 20 + (clumpItems ?? 0) * 20,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: Colors.white54,
              ),
              width: 70,
              height: 60,
            ),
          ),
        ],
      ),
    );
  }
}
