import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';

import '../../providers/item_categories.dart';
import '../../providers/items.dart';

import '../../widgets/popup_add_category.dart';

class ItemsCategoriesScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final _selectCategory = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: _selectCategory == null ? NormalAppBar() : SelectAppBar(),
      body: Consumer<ItemCategories>(
        builder: (context, data, child) => ListView.builder(
          itemBuilder: (context, i) => ChangeNotifierProvider(
            create: (context) => Items(),
            child: ItemCategoryItem(data.categories[i].title, _selectCategory),
          ),
          itemCount: data.categories.length,
        ),
      ),
    );
  }
}

// Single Category Item
class ItemCategoryItem extends StatelessWidget {
  final String title;
  final bool select;

  ItemCategoryItem(this.title, this.select);

  void onTap(BuildContext context) {
    if (select == true) {
      Navigator.of(context).pop(title);
    } else {
      Navigator.of(context).pushNamed('/item', arguments: title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onTap(context),
        child: ListTile(
          title: Text(title),
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
  get preferredSize => new Size.fromHeight(kToolbarHeight);

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
  void _addNewCategory(BuildContext context, String name) {
    if (name.isEmpty) {
      return;
    }
    Provider.of<ItemCategories>(context, listen: false).insertCategory(name);

    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  get preferredSize => new Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Select'),
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: [
        PopUpAddCategory(_addNewCategory),
      ],
    );
  }
}
