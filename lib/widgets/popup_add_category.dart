import 'package:flutter/material.dart';

enum Popup { NewCategory }

class PopUpAddCategory extends StatelessWidget {
  final Function(BuildContext, String) _addNewCategory;

  PopUpAddCategory(this._addNewCategory);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text('New Category'),
          value: Popup.NewCategory,
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case Popup.NewCategory:
            showDialog(
                context: context,
                builder: (context) {
                  final controller = TextEditingController();
                  bool isEnabled = false;
                  return StatefulBuilder(
                    builder: (context, state) => AlertDialog(
                      title: Text('New Category'),
                      content: TextField(
                        controller: controller,
                        autofocus: true,
                        decoration: InputDecoration(labelText: 'Name'),
                        onChanged: (value) {
                          state(() {
                            print(value);
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
                                ? () =>
                                    _addNewCategory(context, controller.text)
                                : null,
                            child: Text('Create'))
                      ],
                    ),
                  );
                });
            break;
        }
      },
    );
  }
}
