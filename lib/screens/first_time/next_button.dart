import 'package:flutter/material.dart';

import 'second_page.dart';
import 'third_page.dart';
import 'fourth_page.dart';
import 'fifth_page.dart';

enum PageName { Home, Second, Third, Fourth, Fifth }

class NextButton extends StatelessWidget {
  final PageName page;
  final Duration duration;
  NextButton({this.page, this.duration = const Duration(seconds: 1)});

  void _next(BuildContext context) {
    page != PageName.Home
        ? Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                switch (page) {
                  case PageName.Second:
                    return SecondScreen();
                  case PageName.Third:
                    return ThirdScreen();
                  case PageName.Fourth:
                    return FourthScreen();
                  case PageName.Fifth:
                    return FifthScreen();
                  default:
                    return null;
                }
              },
              transitionDuration: duration,
            ),
          )
        : Navigator.of(context).pushNamedAndRemoveUntil('/', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 70),
      child: FlatButton(
        color: Colors.black12,
        onPressed: () => _next(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Continue',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
