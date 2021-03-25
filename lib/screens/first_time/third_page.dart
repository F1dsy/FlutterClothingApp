import '../first_time/box_outline.dart';
import 'package:flutter/material.dart';
import 'title_widget.dart';

import 'second_page.dart';

import 'next_button.dart';
import 'background.dart';

class ThirdScreen extends StatelessWidget {
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
                TitleWidget(animation: animation, stage: Stage.FadeOut),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 1 - animation.value,
                        child: CategoryBox(),
                      ),
                      Opacity(
                        opacity: animation.value,
                        child: ItemBox(animation: animation),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            NextButton(
              page: PageName.Fourth,
              duration: Duration(seconds: 3),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemBox extends StatelessWidget {
  final Animation animation;
  ItemBox({this.animation});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BoxOutline(
            child: Transform(
          transform: Matrix4.translationValues(
              0,
              CurvedAnimation(curve: Curves.ease, parent: animation)
                  .drive(Tween<double>(begin: 200, end: 0))
                  .value,
              0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 70,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white54,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(11),
                        topRight: Radius.circular(11),
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(3),
                      ),
                      color: Colors.white54,
                    ),
                    width: 70,
                    height: 30,
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white54,
                    ),
                    width: 70,
                    height: 80,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(11),
                        topRight: Radius.circular(11),
                        bottomLeft: Radius.circular(3),
                        bottomRight: Radius.circular(7),
                      ),
                      color: Colors.white54,
                    ),
                    width: 70,
                    height: 60,
                  )
                ],
              ),
            ],
          ),
        )),
        Container(
          width: 220,
          margin: EdgeInsets.only(top: 20),
          child: Text(
            'Add items by taking pictures of your clothes',
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
