import '../../models/categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'outfit_builder.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/outfits.dart';
import '../../providers/items.dart';
import '../../models/outfit.dart';
import './outfit_widget.dart';
import 'select_outfit_popup.dart';
import '../../widgets/custom_app_bar.dart';

class OutfitsScreen extends StatefulWidget {
  static const routeName = '/outfit';

  @override
  _OutfitsScreenState createState() => _OutfitsScreenState();
}

class _OutfitsScreenState extends State<OutfitsScreen> {
  bool _selectable = false;
  List<Outfit> _selected = [];

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

  void _addNewOutfit(BuildContext context, OutfitCategory category) {
    if (Provider.of<Items>(context, listen: false).items.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('No Items'),
                content: Text('You need to add Items first'),
                actions: [
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'))
                ],
              ));
    } else {
      Navigator.of(context, rootNavigator: true)
          .pushNamed(OutfitBuilder.routeName, arguments: category);
    }
  }

  void _deleteItems(List<Outfit> outfits) {
    for (var outfit in outfits) {
      Provider.of<Outfits>(context, listen: false).deleteOutfit(outfit);
    }
    setState(() {
      _selected = [];
      _selectable = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final OutfitCategory category = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: !_selectable
          ? NormalAppBar(category, _addNewOutfit)
          : SelectAppBar(
              () {
                setState(() {
                  _selectable = false;
                  _selected = [];
                });
              },
              () => _deleteItems(_selected),
            ),
      body: Consumer<Outfits>(
        builder: (context, data, child) {
          // gets list of outfits in the selected category
          List<Outfit> outfits = data.outfitsOfCategory(category);

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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 65.0),
        child: FloatingActionButton(
          heroTag: null,
          onPressed: () => _addNewOutfit(context, category),
          child: Icon(Icons.add),
          elevation: 4,
        ),
      ),
    );
  }
}

class NormalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final OutfitCategory category;
  final Function addNewOutfit;
  NormalAppBar(this.category, this.addNewOutfit);

  @override
  get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Text(category.title),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => addNewOutfit(context, category),
        ),
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
      title: Text(AppLocalizations.of(context).select),
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: close,
      ),
      actions: [
        SelectOutfitPopup(
          delete: delete,
        ),
      ],
    );
  }
}
