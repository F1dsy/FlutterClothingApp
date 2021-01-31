import 'package:flutter/material.dart';

enum Popups {
  RemoveFromBasket,
}

class SelectWashPopup extends StatelessWidget {
  final Function remove;

  SelectWashPopup({
    this.remove,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text('Remove from Wash Basket'),
          value: Popups.RemoveFromBasket,
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case Popups.RemoveFromBasket:
            remove();
            break;
          default:
        }
      },
    );
  }
}
