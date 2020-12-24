import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'item_widget.dart';
import '../../providers/items.dart';
import 'add_item_screen.dart';
import '../../models/item.dart';

class ItemsScreen extends StatefulWidget {
  static const routeName = '/item';

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  void _addNewItem(BuildContext context, String name) {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(AddItemScreen.routeName, arguments: name);
    // Navigator.pushNamed(context, AddItemScreen.routeName, arguments: name);
  }

  void toggleSelection(Item item) {
    // print('inToggle ' + item.hashCode.toString());
    setState(() {
      if (!_selectable) {
        _selectable = true;
      }
      if (_selected.contains(item)) {
        _selected.remove(item);
        if (_selected.isEmpty) {
          _selectable = false;
        }
      } else {
        _selected.add(item);
      }

      print(_selected);
    });
  }

  bool _selectable = false;

  List _selected = [];

  @override
  void didChangeDependencies() {
    // print('ChangeDep');
    Provider.of<Items>(context, listen: false).fetchAndSetItems();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final String name = ModalRoute.of(context).settings.arguments;

    return Scaffold(
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
                  itemBuilder: (context, i) {
                    // print('before ' + items[i].hashCode.toString());
                    return ItemWidget(items[i], _selectable, toggleSelection);
                  },
                  itemCount: items.length,
                  staggeredTileBuilder: (_) => StaggeredTile.fit(1),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewItem(context, name),
        child: Icon(Icons.add),
        elevation: 4,
        heroTag: null,
      ),
    );
  }
}
