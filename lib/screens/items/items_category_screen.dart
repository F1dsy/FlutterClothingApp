import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';

import '../../providers/item_categories.dart';
import '../../models/categories.dart';
import '../../widgets/popup_add_category.dart';
import './select_category_popup.dart';
import './item_category_widget.dart';

class ItemsCategoriesScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _ItemsCategoriesScreenState createState() => _ItemsCategoriesScreenState();
}

class _ItemsCategoriesScreenState extends State<ItemsCategoriesScreen> {
  bool _selectable = false;
  List _selected = [];

  void _toggleSelection(ItemCategory category) {
    setState(() {
      if (!_selectable) {
        _selectable = true;
      }
      if (_selected.contains(category)) {
        _selected.remove(category);
        if (_selected.isEmpty) {
          _selectable = false;
        }
      } else {
        _selected.add(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !_selectable
          ? NormalAppBar()
          : SelectAppBar(() {
              setState(() {
                _selectable = false;
                _selected = [];
              });
            }),
      body: Consumer<ItemCategories>(
        builder: (context, data, child) => data.categories.isEmpty
            ? Center(
                child: Text('Add Category First'),
              )
            : ListView.builder(
                itemBuilder: (context, i) => ItemCategoryWidget(
                  data.categories[i],
                  _selectable,
                  _toggleSelection,
                  _selected,
                ),
                itemCount: data.categories.length,
              ),
      ),
    );
  }
}

class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  void _addNewCategory(BuildContext context, String name) {
    if (name.isEmpty) {
      return;
    }
    Provider.of<ItemCategories>(context, listen: false).insertCategory(name);

    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context).itemsTab),
      actions: [
        PopUpAddCategory(_addNewCategory),
      ],
    );
  }
}

class SelectAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function close;
  SelectAppBar(this.close);

  // void _addNewCategory(BuildContext context, String name) {
  //   if (name.isEmpty) {
  //     return;
  //   }
  //   Provider.of<ItemCategories>(context, listen: false).insertCategory(name);

  //   Navigator.of(context, rootNavigator: true).pop();
  // }

  @override
  get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Select'),
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: close,
      ),
      actions: [
        SelectCategoryPopup(),
      ],
    );
  }
}
