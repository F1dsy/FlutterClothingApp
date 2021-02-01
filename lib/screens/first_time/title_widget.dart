import 'package:flutter/material.dart';

enum Stage {
  Initial,
  FadeIn,
  FadeOut,
}

class TitleWidget extends StatelessWidget {
  final Animation animation;
  final Stage stage;

  TitleWidget({this.animation, this.stage = Stage.Initial});

  @override
  Widget build(BuildContext context) {
    switch (stage) {
      case Stage.Initial:
        return Container(
          margin: EdgeInsets.only(top: 170),
          child: Column(
            children: [
              Text(
                'Welcome to',
                textScaleFactor: 1.3,
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              Text(
                'Fabrics',
                textAlign: TextAlign.center,
                textScaleFactor: 4,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
        break;
      case Stage.FadeIn:
        return Container(
          height: 87,
          margin: EdgeInsets.only(
            top: CurvedAnimation(parent: animation, curve: Curves.ease)
                .drive(Tween<double>(
                  begin: 170,
                  end: 70,
                ))
                .value,
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    'Here you can create your own',
                    textScaleFactor: 1.3,
                    style: TextStyle(
                      color: Colors.white70.withOpacity(animation.value * .7),
                    ),
                  ),
                  Text(
                    'Welcome to',
                    textScaleFactor: 1.3,
                    style: TextStyle(
                      color:
                          Colors.white70.withOpacity(.7 - animation.value * .7),
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    'Virtual Closet',
                    textAlign: TextAlign.center,
                    textScaleFactor: 3,
                    style: TextStyle(
                        color: Colors.white.withOpacity(animation.value)),
                  ),
                  Text(
                    'Fabrics',
                    textAlign: TextAlign.center,
                    textScaleFactor: 4 - animation.value,
                    style: TextStyle(
                      color: Colors.white.withOpacity(1 - animation.value),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        break;
      case Stage.FadeOut:
        return Container(
          margin: EdgeInsets.only(top: 70),
          height: 87,
          child: Column(
            children: [
              Text(
                'Here you can create your own',
                textScaleFactor: 1.3,
                style: TextStyle(
                  color: Colors.white.withOpacity(.7 - animation.value * .7),
                ),
              ),
              Text(
                'Virtual Closet',
                textAlign: TextAlign.center,
                textScaleFactor: 3,
                style: TextStyle(
                    color: Colors.white.withOpacity(1 - animation.value)),
              ),
            ],
          ),
        );
        break;
      default:
        return null;
    }
  }
}
