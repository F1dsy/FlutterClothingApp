import 'package:flutter/material.dart';

enum Popups { Delete }

class SelectCategoryPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text('Delete'),
          value: Popups.Delete,
        ),
      ],
      onSelected: (value) {},
    );
  }
}
