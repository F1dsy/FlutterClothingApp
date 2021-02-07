import '../../models/categories.dart';
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
import '../../helpers/selection_handler.dart';

class ItemsScreen extends StatefulWidget {
  static const routeName = '/item';

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  SelectionHandler<Item> selectionHandler;
  @override
  initState() {
    selectionHandler = SelectionHandler<Item>(setState);
    super.initState();
  }

  void _addNewItem(BuildContext context, ItemCategory category) {
    Navigator.of(context, rootNavigator: true)
        .pushNamed(AddItemScreen.routeName, arguments: category);
  }

  void _deleteItems(List<Item> items) {
    for (var item in items) {
      Provider.of<Items>(context, listen: false).deleteItem(item);
    }
    selectionHandler.reset();
  }

  void _moveToCategory() {
    Navigator.of(context).pushNamed(MoveItem.routeName).then((value) {
      if (value == null) return;
      Provider.of<Items>(context, listen: false)
          .moveToCategory(selectionHandler.selectedList, value);

      selectionHandler.reset();
    });
  }

  Widget _buildNormalAppBar(ItemCategory category) => CustomAppBar(
        title: Text(category.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addNewItem(context, category),
          ),
        ],
      );

  Widget _buildSelectAppBar() => CustomAppBar(
        title: Text(selectionHandler.selectedList.length.toString() +
            ' ' +
            AppLocalizations.of(context).selected),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            selectionHandler.reset();
          },
        ),
        actions: [
          SelectItemsPopup(
            delete: () => _deleteItems(selectionHandler.selectedList),
            move: _moveToCategory,
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    final ItemCategory category = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: selectionHandler.isSelectable
          ? _buildSelectAppBar()
          : _buildNormalAppBar(category),
      body: Consumer<Items>(
        builder: (context, data, child) {
          var items = data.items[category];
          return items.isEmpty
              ? Center(
                  child: Text('No Items'),
                )
              : StaggeredGridView.countBuilder(
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 3,
                  itemBuilder: (context, i) {
                    return ItemWidget(
                      items[i],
                      selectionHandler.toggleSelection,
                      selectionHandler.isSelectable,
                      selectionHandler.selectedList,
                    );
                  },
                  itemCount: items.length,
                  staggeredTileBuilder: (_) => StaggeredTile.fit(1),
                );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 65.0),
        child: FloatingActionButton(
          onPressed: () => _addNewItem(context, category),
          child: Icon(Icons.add),
          heroTag: null,
        ),
      ),
    );
  }
}
