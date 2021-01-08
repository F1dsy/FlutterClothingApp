import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

enum Popup { NewCategory }

class PopUpAddCategory extends StatelessWidget {
  final Function(BuildContext, String) _addNewCategory;

  PopUpAddCategory(this._addNewCategory);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text(AppLocalizations.of(context).newCategory),
          value: Popup.NewCategory,
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case Popup.NewCategory:
            _newCategory(context, _addNewCategory);
            break;
        }
      },
    );
  }
}

Future _newCategory(BuildContext context, Function _addNewCategory) {
  return showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        bool isEnabled = false;
        return StatefulBuilder(
          builder: (context, state) => AlertDialog(
            title: Text(AppLocalizations.of(context).newCategory),
            content: TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                state(() {
                  if (value != '') {
                    isEnabled = true;
                  } else {
                    isEnabled = false;
                  }
                });
              },
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: isEnabled
                      ? () => _addNewCategory(context, controller.text)
                      : null,
                  child: Text('Create'))
            ],
          ),
        );
      });
}
