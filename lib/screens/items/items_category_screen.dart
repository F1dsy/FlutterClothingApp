import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';

import '../../providers/item_categories.dart';
import '../../models/categories.dart';
import '../../widgets/popup_add_category.dart';
import './select_category_popup.dart';
import './item_category_widget.dart';
import '../../widgets/custom_app_bar.dart';
import '../../helpers/selection_handler.dart';

class ItemsCategoriesScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _ItemsCategoriesScreenState createState() => _ItemsCategoriesScreenState();
}

class _ItemsCategoriesScreenState extends State<ItemsCategoriesScreen> {
  SelectionHandler<ItemCategory> selectionHandler;
  @override
  initState() {
    selectionHandler = SelectionHandler<ItemCategory>(setState);
    super.initState();
  }

  void _deleteCategories() {
    for (var category in selectionHandler.selectedList) {
      Provider.of<ItemCategories>(context, listen: false)
          .deleteCategory(category)
          .then(
        (value) {
          selectionHandler.reset();
          if (value) {
            Scaffold.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              elevation: 2,
              margin: EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              content: Text(
                'Could not Delete Category, since there are still Items inside',
              ),
            ));
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !selectionHandler.isSelectable
          ? NormalAppBar()
          : SelectAppBar(
              selectionHandler.reset,
              _deleteCategories,
            ),
      body: Consumer<ItemCategories>(
        builder: (context, data, child) => data.categories.isEmpty
            ? Center(
                child: Text('Add Category First'),
              )
            : ListView.builder(
                itemBuilder: (context, i) => ItemCategoryWidget(
                  data.categories[i],
                  selectionHandler.toggleSelection,
                  selectionHandler.isSelectable,
                  selectionHandler.selectedList,
                ),
                itemCount: data.categories.length,
              ),
      ),
    );
  }
}

class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  void _addNewCategory(BuildContext context, String name) {
    if (name.isEmpty) {
      return;
    }
    Provider.of<ItemCategories>(context, listen: false).insertCategory(name);

    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Text(AppLocalizations.of(context).itemsTab),
      actions: [
        PopUpAddCategory(_addNewCategory),
      ],
    );
  }
}

class SelectAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function close;
  final Function delete;
  SelectAppBar(this.close, this.delete);

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
        SelectCategoryPopup(
          delete: delete,
        ),
      ],
    );
  }
}
