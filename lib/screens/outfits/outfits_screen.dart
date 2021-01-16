import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'outfit_builder.dart';
import '../../providers/outfits.dart';
import '../../models/outfit.dart';
import './outfit_widget.dart';

class OutfitsScreen extends StatefulWidget {
  static const routeName = '/outfit';

  @override
  _OutfitsScreenState createState() => _OutfitsScreenState();
}

class _OutfitsScreenState extends State<OutfitsScreen> {
  bool _selectable = false;
  List _selected = [];

  void _toggleSelection(Outfit category) {
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

  void _addNewOutfit(BuildContext context, String name) {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(OutfitBuilder.routeName, arguments: name);
  }

  @override
  Widget build(BuildContext context) {
    final String name = ModalRoute.of(context).settings.arguments;
    // Provider.of<Items>(context, listen: false).fetchAndSetItems();
    // Provider.of<Outfits>(context, listen: false).fetchAndSetOutfits(context);
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
                  itemBuilder: (context, i) => OutfitWidget(
                    outfits[i],
                    _selectable,
                    _toggleSelection,
                    _selected,
                  ),
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
