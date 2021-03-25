import '../first_time/box_outline.dart';
import 'package:flutter/material.dart';

import 'title_widget.dart';
import 'next_button.dart';
import 'background.dart';

class SecondScreen extends StatelessWidget {
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
                TitleWidget(animation: animation, stage: Stage.FadeIn),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Opacity(
                    opacity: animation.value,
                    child: CategoryBox(),
                  ),
                ),
              ],
            ),
            NextButton(page: PageName.Third),
          ],
        ),
      ),
    );
  }
}

class CategoryBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            BoxOutline(
              child: ClipRect(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    3,
                    (i) => Container(
                      height: 40,
                      width: 125,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: -15,
              child: Container(
                height: 60,
                width: 60,
                child: Icon(
                  Icons.add,
                  size: 35,
                  color: Colors.deepPurple,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFBCA4DE),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        offset: Offset(0, 3),
                        color: Colors.black26,
                      )
                    ]),
              ),
            ),
          ],
        ),
        Container(
          width: 220,
          margin: EdgeInsets.only(top: 20),
          child: Text(
            'Start by creating categories for your clothes',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
