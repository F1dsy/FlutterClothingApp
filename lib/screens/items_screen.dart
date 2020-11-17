import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widgets/drawer.dart';
import '../providers/items.dart';
// import '../screens/add_item_screen.dart';

class ItemsScreen extends StatelessWidget {
  static const routeName = '/item';
  void _addNewItem(BuildContext context, String name) {
    Navigator.pushNamed(context, '/newItem', arguments: name);
  }

  @override
  Widget build(BuildContext context) {
    final String name = ModalRoute.of(context).settings.arguments;
    Provider.of<Items>(context, listen: false).fetchAndSetItems();
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addNewItem(context, name),
          ),
        ],
      ),
      body: Consumer<Items>(
        builder: (context, data, child) {
          var items = data.itemsOfCategory(name);
          return items.isEmpty
              ? Center(
                  child: Text('No Items'),
                )
              : StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemBuilder: (context, i) =>
                      Item(items[i].category, items[i].imageURL),
                  itemCount: items.length,
                  staggeredTileBuilder: (_) => StaggeredTile.fit(1),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewItem(context, name),
        child: Icon(Icons.add),
        elevation: 4,
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String title;
  final String file;
  Item(this.title, this.file);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Image.file(
          File(file),
        ),
      ),
    );
  }
}
