import 'package:flutter/material.dart';

import 'background.dart';
import 'next_button.dart';
import 'box_outline.dart';
import 'outfit_item.dart';
import 'fourth_page.dart';

class FifthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Animation animation = ModalRoute.of(context)!.animation!;

    return Background(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 50, top: 80),
              child: CalendarItem(animation: animation),
            ),
            NextButton(page: PageName.Home),
          ],
        ),
      ),
    );
  }
}

class CalendarItem extends StatelessWidget {
  final Animation? animation;
  CalendarItem({this.animation});

  @override
  Widget build(BuildContext context) {
    Animation plus = CurveTween(curve: Interval(0.6, 0.9, curve: Curves.ease))
        .animate(animation as Animation<double>);
    Animation calendar = CurveTween(curve: Interval(0.7, 1, curve: Curves.ease))
        .animate(animation as Animation<double>);
    Animation text = CurveTween(curve: Interval(0, 0.4, curve: Curves.ease))
        .animate(animation as Animation<double>);
    Animation arrow =
        CurveTween(curve: Interval(0.20, 0.30, curve: Curves.ease))
            .animate(animation as Animation<double>);
    return Column(
      children: [
        BoxOutline(
          height: 380,
          child: Stack(
            children: [
              Column(
                children: [
                  Clump(
                    fadeOutAnimation: CurvedAnimation(
                      parent: animation as Animation<double>,
                      curve: Interval(0, 0.25),
                    ),
                  ),
                  Expanded(
                    child: Opacity(
                      opacity: 1 - arrow.value as double,
                      child: Icon(
                        Icons.arrow_downward_rounded,
                        color: Colors.white54,
                        size: 40,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 130,
                    child: Transform(
                      transform: Matrix4.translationValues(
                          0,
                          animation!
                              .drive(Tween<double>(begin: 203, end: 0).chain(
                                  CurveTween(
                                      curve: Interval(0.15, 0.7,
                                          curve: Curves.ease))))
                              .value,
                          0),
                      child: Container(
                        // color: Colors.blue,
                        margin: EdgeInsets.only(top: 30),
                        child: Center(
                          child: OutfitItem(),
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: plus.value,
                    child: Icon(
                      Icons.add,
                      color: Colors.white54,
                      size: 40,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    // color: Colors.amber,
                    child: Opacity(
                      opacity: calendar.value,
                      child: Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.white54,
                        size: 120,
                      ),
                    ),
                  )
                ],
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
                'Combine your items to elaborate outfits',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7 - text.value * 0.7),
                  fontSize: 16,
                ),
              ),
              Text(
                'Plan ahead and select your favourite outfit for the coming event',
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
