// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widgets/drawer.dart';
import '../providers/outfits.dart';
// import '../screens/add_item_screen.dart';

class OutfitsScreen extends StatelessWidget {
  static const routeName = '/outfit';
  void _addNewItem(BuildContext context, String name) {
    Navigator.pushNamed(context, '/newItem', arguments: name);
  }

  @override
  Widget build(BuildContext context) {
    final String name = ModalRoute.of(context).settings.arguments;
    Provider.of<Outfits>(context, listen: false).fetchAndSetItems();
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
      body: Consumer<Outfits>(
        builder: (context, data, child) {
          var items = data.itemsOfCategory(name);
          return items.isEmpty
              ? Center(
                  child: Text('No Outfits'),
                )
              : StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemBuilder: (context, i) => Outfit(items[i].categories),
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

class Outfit extends StatelessWidget {
  final List<String> title;

  Outfit(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(),
    );
  }
}
