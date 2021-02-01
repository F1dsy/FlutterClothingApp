import 'package:flutter/material.dart';

import 'title_widget.dart';
import 'next_button.dart';

import 'background.dart';

class FirstTimeScreen extends StatelessWidget {
  static const routeName = '/firstTime';

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleWidget(),
          NextButton(page: PageName.Second),
        ],
      ),
    );
  }
}
