import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item_categories.dart';
import '../providers/items.dart';
import '../widgets/drawer.dart';

enum Popup { NewCategory }

class ItemsCategoriesScreen extends StatefulWidget {
  @override
  _ItemsCategoriesScreenState createState() => _ItemsCategoriesScreenState();
}

class _ItemsCategoriesScreenState extends State<ItemsCategoriesScreen> {
  void _addNewCategory(String name) {
    if (name.isEmpty) {
      return;
    }
    Provider.of<ItemCategories>(context, listen: false).insertCategory(name);
    Provider.of<ItemCategories>(context, listen: false).fetchAndSetCategories();
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: const Text('Items'),
        actions: [
          PopupMenuButton(
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
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  child: Text('Cancel')),
                              FlatButton(
                                  onPressed: isEnabled
                                      ? () => _addNewCategory(controller.text)
                                      : null,
                                  child: Text('Create'))
                            ],
                          ),
                        );
                      });
                  break;
                default:
              }
            },
          ),
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
        elevation: 4,
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
