import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';

import '../../providers/item_categories.dart';
import '../../providers/items.dart';
import '../../models/item.dart';
import '../../widgets/custom_app_bar.dart';
import '../items/item_widget.dart';
import '../../helpers/selection_handler.dart';
import 'select_wash_popup.dart';

class WashBasketScreen extends StatefulWidget {
  static const routeName = '/wash-basket';

  @override
  _WashBasketScreenState createState() => _WashBasketScreenState();
}

class _WashBasketScreenState extends State<WashBasketScreen> {
  SelectionHandler<Item> selectionHandler;

  @override
  void initState() {
    selectionHandler = SelectionHandler<Item>(setState);
    super.initState();
  }

  void _removeFromBasket(List<Item> items) {
    for (var item in items) {
      Provider.of<Items>(context, listen: false).removeFromWashBasket(item);
    }
    selectionHandler.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: selectionHandler.isSelectable
          ? SelectAppBar(
              selectionHandler.reset,
              () => _removeFromBasket(selectionHandler.selectedList),
            )
          : NormalAppBar(),
      body: Container(
        child: Consumer2<ItemCategories, Items>(
          builder: (context, categories, items, child) => ListView.builder(
            itemBuilder: (context, i) {
              List<Item> inWashItems = items.items[categories.categories[i]]
                  .where((item) => item.isInWash == true)
                  .toList();
              if (inWashItems.isEmpty) {
                return Container();
              }
              return Column(
                children: [
                  ListTile(
                    title: Text(categories.categories[i].title),
                  ),
                  Container(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, j) => ItemWidget(
                        inWashItems[j],
                        selectionHandler.toggleSelection,
                        selectionHandler.isSelectable,
                        selectionHandler.selectedList,
                      ),
                      itemCount: inWashItems.length,
                    ),
                  )
                ],
              );
            },
            itemCount: categories.categories.length,
          ),
        ),
      ),
    );
  }
}

class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Text(AppLocalizations.of(context).washBasket),
    );
  }
}

class SelectAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function close;
  final Function remove;
  SelectAppBar(this.close, this.remove);

  @override
  get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: const Text('Select'),
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: close,
      ),
      actions: [
        SelectWashPopup(
          remove: remove,
        ),
      ],
    );
  }
}
