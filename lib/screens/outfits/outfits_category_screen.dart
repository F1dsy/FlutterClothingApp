import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';

import '../../widgets/popup_add_category.dart';
import '../../providers/outfit_categories.dart';
import './outfit_category_widget.dart';
import '../../models/categories.dart';
import './select_category_popup.dart';
import '../../widgets/custom_app_bar.dart';
import '../../helpers/selection_handler.dart';

class OutfitsCategoriesScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _OutfitsCategoriesScreenState createState() =>
      _OutfitsCategoriesScreenState();
}

class _OutfitsCategoriesScreenState extends State<OutfitsCategoriesScreen> {
  SelectionHandler<OutfitCategory> selectionHandler;

  @override
  initState() {
    selectionHandler = SelectionHandler<OutfitCategory>(setState);
    super.initState();
  }

  void _deleteCategories() {
    for (var category in selectionHandler.selectedList) {
      Provider.of<OutfitCategories>(context, listen: false)
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
          : SelectAppBar(selectionHandler, _deleteCategories),
      body: Consumer<OutfitCategories>(
        builder: (context, data, child) => data.categories.isEmpty
            ? Center(child: Text('Add Category First'))
            : ListView.builder(
                itemBuilder: (context, i) => OutfitCategoryWidget(
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
    Provider.of<OutfitCategories>(context, listen: false).insertCategory(name);
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Text(AppLocalizations.of(context).outfitsTab),
      actions: [
        PopUpAddCategory(_addNewCategory),
      ],
    );
  }
}

class SelectAppBar extends StatelessWidget implements PreferredSizeWidget {
  final SelectionHandler selectionHandler;
  final Function delete;
  SelectAppBar(this.selectionHandler, this.delete);

  @override
  get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Text(selectionHandler.selectedList.length.toString() +
          ' ' +
          AppLocalizations.of(context).select),
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: selectionHandler.reset,
      ),
      actions: [
        SelectCategoryPopup(
          delete: delete,
        ),
      ],
    );
  }
}
