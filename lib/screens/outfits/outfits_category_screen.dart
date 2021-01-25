import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';

import '../../widgets/popup_add_category.dart';
import '../../providers/outfit_categories.dart';
import './outfit_category_widget.dart';
import '../../models/categories.dart';
import './select_category_popup.dart';
import '../../widgets/custom_app_bar.dart';

class OutfitsCategoriesScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _OutfitsCategoriesScreenState createState() =>
      _OutfitsCategoriesScreenState();
}

class _OutfitsCategoriesScreenState extends State<OutfitsCategoriesScreen> {
  bool _selectable = false;
  List _selected = [];

  void _toggleSelection(OutfitCategory category) {
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

  void _resetSelection() {
    setState(() {
      _selectable = false;
      _selected = [];
    });
  }

  void _deleteCategories() {
    for (var category in _selected) {
      Provider.of<OutfitCategories>(context, listen: false)
          .deleteCategory(category)
          .then(
        (value) {
          _resetSelection();
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
      appBar: !_selectable
          ? NormalAppBar()
          : SelectAppBar(_resetSelection, _deleteCategories),
      body: Consumer<OutfitCategories>(
        builder: (context, data, child) => data.categories.isEmpty
            ? Center(child: Text('Add Category First'))
            : ListView.builder(
                itemBuilder: (context, i) => OutfitCategoryWidget(
                  data.categories[i],
                  _selectable,
                  _toggleSelection,
                  _selected,
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
