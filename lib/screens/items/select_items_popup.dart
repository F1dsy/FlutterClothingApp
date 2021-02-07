import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

enum Popups {
  Delete,
  Move,
}

class SelectItemsPopup extends StatelessWidget {
  final Function delete;
  final Function move;

  SelectItemsPopup({
    this.delete,
    this.move,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text(AppLocalizations.of(context).delete),
          value: Popups.Delete,
        ),
        PopupMenuItem(
          child: Text(AppLocalizations.of(context).moveToCategory),
          value: Popups.Move,
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case Popups.Delete:
            delete();
            break;
          case Popups.Move:
            move();
            break;
          default:
        }
      },
    );
  }
}
