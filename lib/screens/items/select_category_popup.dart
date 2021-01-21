import 'package:flutter/material.dart';

enum Popups { Delete }

class SelectCategoryPopup extends StatelessWidget {
  final Function delete;
  SelectCategoryPopup({this.delete});
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text('Delete'),
          value: Popups.Delete,
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case Popups.Delete:
            delete();
            break;
          default:
        }
      },
    );
  }
}
