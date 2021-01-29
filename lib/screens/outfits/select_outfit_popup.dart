import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

enum Popups {
  Delete,
  Move,
  AddToBasket,
  RemoveFromBasket,
}

class SelectOutfitPopup extends StatelessWidget {
  final Function delete;
  final Function move;
  final Function addToBasket;
  final Function removeFromBasket;

  SelectOutfitPopup({
    this.delete,
    this.move,
    this.addToBasket,
    this.removeFromBasket,
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
        PopupMenuItem(
          child: Text('Add to Basket'),
          value: Popups.AddToBasket,
        ),
        PopupMenuItem(
          child: Text('Remove from Basket'),
          value: Popups.RemoveFromBasket,
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
          case Popups.AddToBasket:
            addToBasket();
            break;
          case Popups.RemoveFromBasket:
            removeFromBasket();
            break;
          default:
        }
      },
    );
  }
}
