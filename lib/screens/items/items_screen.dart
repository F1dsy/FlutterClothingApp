import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../l10n/app_localizations.dart';
import 'item_widget.dart';
import '../../providers/items.dart';
import 'add_item_screen.dart';
import '../../models/item.dart';
import '../../screens/items/move_item.dart';
import './select_items_popup.dart';
import '../../widgets/custom_app_bar.dart';

class ItemsScreen extends StatefulWidget {
  static const routeName = '/item';

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  bool _selectable = false;
  List<Item> _selected = [];

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
    });
  }

  void _deleteItems(List<Item> items) {
    for (var item in items) {
      Provider.of<Items>(context, listen: false).deleteItem(item);
    }
    setState(() {
      _selected = [];
      _selectable = false;
    });
  }

  void _addToBasket(List<Item> items) {
    for (var item in items) {
      Provider.of<Items>(context, listen: false).addToWashBasket(item);
    }
    setState(() {
      _selected = [];
      _selectable = false;
    });
  }

  void _removeFromBasket(List<Item> items) {
    for (var item in items) {
      Provider.of<Items>(context, listen: false).removeFromWashBasket(item);
    }
    setState(() {
      _selected = [];
      _selectable = false;
    });
  }

  void _moveToCategory() {
    Navigator.of(context).pushNamed(MoveItem.routeName).then((value) {
      if (value == null) return;
      Provider.of<Items>(context, listen: false)
          .moveToCategory(_selected, value);
      setState(() {
        _selected = [];
        _selectable = false;
      });
    });
  }

  Widget _buildNormalAppBar(name) => CustomAppBar(
        title: Text(name),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addNewItem(context, name),
          ),
        ],
      );

  Widget _buildSelectAppBar() => CustomAppBar(
        title: Text(AppLocalizations.of(context).select),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            setState(() {
              _selected = [];
              _selectable = false;
            });
          },
        ),
        actions: [
          SelectItemsPopup(
            delete: () => _deleteItems(_selected),
            move: _moveToCategory,
            addToBasket: () => _addToBasket(_selected),
            removeFromBasket: () => _removeFromBasket(_selected),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final String name = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: _selectable ? _buildSelectAppBar() : _buildNormalAppBar(name),
      body: Consumer<Items>(
        builder: (context, data, child) {
          var items = data.itemsOfCategory(name);
          return items.isEmpty
              ? Center(
                  child: Text('No Items'),
                )
              : StaggeredGridView.countBuilder(
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 3,
                  itemBuilder: (context, i) {
                    return ItemWidget(
                        items[i], _selectable, toggleSelection, _selected);
                    // return Container(
                    //   height: 100,
                    //   child: const Text('hiii'),
                    // );
                  },
                  itemCount: items.length,
                  staggeredTileBuilder: (_) => StaggeredTile.fit(1),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewItem(context, name),
        child: Icon(Icons.add),
        heroTag: null,
      ),
    );
  }
}
