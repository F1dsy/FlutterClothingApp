import 'package:flutter/material.dart';

import 'next_button.dart';
import 'outfit_item.dart';
import 'background.dart';

class FourthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Animation animation = ModalRoute.of(context)!.animation!;

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
              duration: Duration(seconds: 3),
            ),
          ],
        ),
      ),
    );
  }
}

class OutfitBox extends StatelessWidget {
  final Animation? animation;
  OutfitBox({this.animation});

  @override
  Widget build(BuildContext context) {
    Animation height = Tween<double>(begin: 220, end: 380)
        .chain(CurveTween(curve: Interval(0, 0.4, curve: Curves.ease)))
        .animate(animation as Animation<double>);
    Animation clumpItems = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Interval(0.4, 0.7, curve: Curves.ease)))
        .animate(animation as Animation<double>);
    Animation arrow = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Interval(0.6, 0.9, curve: Curves.ease)))
        .animate(animation as Animation<double>);
    Animation outfit = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Interval(0.7, 1, curve: Curves.ease)))
        .animate(animation as Animation<double>);
    Animation text = CurveTween(curve: Interval(0, 0.4, curve: Curves.ease))
        .animate(animation as Animation<double>);

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
          child: Stack(
            children: [
              Text(
                'Add items by taking pictures of your clothes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7 - text.value * 0.7),
                  fontSize: 16,
                ),
              ),
              Text(
                'Combine your items to elaborate outfits',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(text.value * 0.7),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Clump extends StatelessWidget {
  final double? clumpItems;
  final Animation? fadeOutAnimation;
  Clump({this.clumpItems = 1, this.fadeOutAnimation});
  @override
  Widget build(BuildContext context) {
    double? firstOpacity;
    double? secondOpacity;
    double? thirdOpacity;
    double? fourthOpacity;
    if (fadeOutAnimation != null) {
      firstOpacity = 1 -
          CurveTween(curve: Interval(0, 0.55, curve: Curves.ease))
              .animate(fadeOutAnimation as Animation<double>)
              .value;
      secondOpacity = 1 -
          CurveTween(curve: Interval(0.15, 0.70, curve: Curves.ease))
              .animate(fadeOutAnimation as Animation<double>)
              .value;
      thirdOpacity = 1 -
          CurveTween(curve: Interval(0.30, 0.85, curve: Curves.ease))
              .animate(fadeOutAnimation as Animation<double>)
              .value;
      fourthOpacity = 1 -
          CurveTween(curve: Interval(0.45, 1, curve: Curves.ease))
              .animate(fadeOutAnimation as Animation<double>)
              .value;
    }

    return Container(
      height: 180,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 20,
            left: 20 + (clumpItems ?? 0) * 10,
            child: Opacity(
              opacity: firstOpacity ?? 1,
              child: Container(
                width: 70,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Colors.white54,
                ),
              ),
            ),
          ),
          Positioned(
            top: 150 - (clumpItems ?? 0) * 35,
            left: 20 + (clumpItems ?? 0) * 25,
            child: Opacity(
              opacity: secondOpacity ?? 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Colors.white54,
                ),
                width: 70,
                height: 30,
              ),
            ),
          ),
          Positioned(
            top: 20 + (clumpItems ?? 0) * 40,
            right: 20 + (clumpItems ?? 0) * 30,
            child: Opacity(
              opacity: thirdOpacity ?? 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Colors.white54,
                ),
                width: 70,
                height: 80,
              ),
            ),
          ),
          Positioned(
            top: 120 - (clumpItems ?? 0) * 15,
            right: 20 + (clumpItems ?? 0) * 20,
            child: Opacity(
              opacity: fourthOpacity ?? 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Colors.white54,
                ),
                width: 70,
                height: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
