import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';

import '../../providers/item_categories.dart';
import '../../providers/items.dart';

import '../../widgets/popup_add_category.dart';

class ItemsCategoriesScreen extends StatelessWidget {
  static const routeName = '/';
  void _addNewCategory(BuildContext context, String name) {
    if (name.isEmpty) {
      return;
    }
    Provider.of<ItemCategories>(context, listen: false).insertCategory(name);
    // Provider.of<ItemCategories>(context, listen: false).fetchAndSetCategories();
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).itemsTab),
        actions: [
          PopUpAddCategory(_addNewCategory),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ItemCategories>(context, listen: false)
            .fetchAndSetCategories(),
        builder: (context, snapshot) => Consumer<ItemCategories>(
          builder: (context, data, child) => ListView.builder(
            itemBuilder: (context, i) => ChangeNotifierProvider(
              create: (context) => Items(),
              child: ItemCategoryItem(data.categories[i].title),
            ),
            itemCount: data.categories.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/newItem');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// Single Category Item
class ItemCategoryItem extends StatelessWidget {
  final String title;

  ItemCategoryItem(this.title);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/item', arguments: title);
        },
        child: ListTile(
          title: Text(title),
        ),
      ),
    );
  }
}
