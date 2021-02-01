import 'package:flutter/material.dart';

import 'background.dart';
import 'next_button.dart';
import 'box_outline.dart';
import 'outfit_item.dart';
import 'fourth_page.dart';

class FifthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Animation animation = ModalRoute.of(context).animation;

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
  final Animation animation;
  CalendarItem({this.animation});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BoxOutline(
          height: 380,
          child: Stack(
            children: [
              Column(
                children: [
                  Opacity(
                    opacity: 1 - animation.value,
                    child: Clump(),
                  ),
                  Expanded(
                    child: Opacity(
                      opacity: 1 - animation.value,
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
                          animation
                              .drive(Tween<double>(begin: 200, end: 0)
                                  .chain(CurveTween(curve: Curves.ease)))
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
                    opacity: animation.value,
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
                      opacity: animation.value,
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
          child: Text(
            'Plan ahead and select your favourite outfit for the coming event',
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
