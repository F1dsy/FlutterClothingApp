import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'outfit_builder.dart';
// import '../../widgets/drawer.dart';
import '../../providers/outfits.dart';
import '../../providers/items.dart';
import '../../models/outfit.dart';
import '../../models/item.dart';
// import '../screens/add_item_screen.dart';

class OutfitsScreen extends StatelessWidget {
  static const routeName = '/outfit';
  void _addNewOutfit(BuildContext context, String name) {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(OutfitBuilder.routeName, arguments: name);
  }

  @override
  Widget build(BuildContext context) {
    final String name = ModalRoute.of(context).settings.arguments;
    Provider.of<Items>(context, listen: false).fetchAndSetItems();
    Provider.of<Outfits>(context, listen: false).fetchAndSetOutfits(context);
    return Scaffold(
      // drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addNewOutfit(context, name),
          ),
        ],
      ),
      body: Consumer<Outfits>(
        builder: (context, data, child) {
          // gets list of outfits in the selected category
          List<Outfit> outfits = data.outfitsOfCategory(name);

          return outfits.isEmpty
              ? Center(
                  child: Text('No Outfits'),
                )
              : StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemBuilder: (context, i) =>
                      OutfitWidget(outfits[i].categories, outfits[i].items),
                  itemCount: outfits.length,
                  staggeredTileBuilder: (_) => StaggeredTile.fit(1),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () => _addNewOutfit(context, name),
        child: Icon(Icons.add),
        elevation: 4,
      ),
    );
  }
}

class OutfitWidget extends StatelessWidget {
  final List<String> title;
  final List<Item> items;

  OutfitWidget(this.title, this.items);
  Widget _build() {
    switch (items.length) {
      case 1:
        return Expanded(child: Image.file(File(items[0].image)));
        break;
      case 2:
        return Row(
          children: [
            Expanded(child: Image.file(File(items[0].image))),
            Expanded(child: Image.file(File(items[1].image))),
          ],
        );
        break;
      case 3:
        return Column(
          children: [
            Row(
              children: [
                Expanded(child: Image.file(File(items[0].image))),
              ],
            ),
            Row(
              children: [
                Expanded(child: Image.file(File(items[1].image))),
                Expanded(child: Image.file(File(items[2].image))),
              ],
            )
          ],
        );
        break;
      default:
        return Column(
          children: [
            Row(
              children: [
                Expanded(child: Image.file(File(items[0].image))),
                Expanded(child: Image.file(File(items[1].image))),
              ],
            ),
            Row(
              children: [
                Expanded(child: Image.file(File(items[2].image))),
                Expanded(child: Image.file(File(items[3].image))),
              ],
            )
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(child: _build()),
    );
  }
}
