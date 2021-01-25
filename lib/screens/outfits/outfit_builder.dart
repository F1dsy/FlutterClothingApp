import '../../providers/item_categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../providers/items.dart';
import '../../providers/outfits.dart';
import '../../models/item.dart';
import '../../models/categories.dart';

class OutfitBuilder extends StatefulWidget {
  static const routeName = '/addOutfit';

  @override
  _OutfitBuilderState createState() => _OutfitBuilderState();
}

class _OutfitBuilderState extends State<OutfitBuilder> {
  GlobalKey _appBar = GlobalKey();
  Offset frontCardOffset = Offset(0, 0);
  int _currentIndex = 0;
  ItemCategory _currentCategory;
  List<Item> _items;
  List<Item> _selectedItems = [];

  @override
  void didChangeDependencies() {
    _items = Provider.of<Items>(context).items;
    _currentCategory = Provider.of<ItemCategories>(context).categories.first;
    super.didChangeDependencies();
  }

  void _saveOutfit(List<Item> items) {
    OutfitCategory category = ModalRoute.of(context).settings.arguments;
    Provider.of<Outfits>(context, listen: false)
        .insertOutfit(category, items)
        .then(Navigator.of(context).pop);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Outfit Builder'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _selectedItems.isNotEmpty
                ? () => _saveOutfit(_selectedItems)
                : null,
          )
        ],
        key: _appBar,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 3,
                  itemBuilder: (context, i) => Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.file(
                        _selectedItems[i].image,
                      ),
                    ),
                  ),
                  itemCount: _selectedItems.length,
                  staggeredTileBuilder: (_) => StaggeredTile.fit(1),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: DropdownButton(
                underline: Container(),
                isExpanded: true,
                value: _currentCategory,
                onChanged: (ItemCategory category) {
                  setState(() {
                    _currentCategory = category;
                    _currentIndex = _items.indexWhere(
                      (item) =>
                          item ==
                          _items.firstWhere(
                              (litem) => litem.category == category),
                    );
                  });
                },
                items: Provider.of<ItemCategories>(context)
                    .categories
                    .map(
                      (category) => DropdownMenuItem(
                        child: Container(
                          margin: const EdgeInsets.only(left: 8.0),
                          child: Text(category.title),
                        ),
                        value: category,
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: _currentIndex < _items.length
                  ? Stack(
                      children: [
                        Align(
                          child: Transform.translate(
                            offset: frontCardOffset,
                            child: Card(
                              elevation: 2,
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.file(
                                    _items[_currentIndex].image,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onPanUpdate: (DragUpdateDetails details) {
                            setState(
                              () {
                                frontCardOffset = Offset(
                                    frontCardOffset.dx + details.delta.dx,
                                    frontCardOffset.dy + details.delta.dy);
                              },
                            );
                          },
                          onPanEnd: (DragEndDetails details) {
                            setState(
                              () {
                                if (frontCardOffset.dx > 150) {
                                  _selectedItems.add(_items[_currentIndex]);
                                  _items.remove(_items[_currentIndex]);
                                  _currentIndex = _currentIndex + 1;
                                } else if (frontCardOffset.dx < -150) {
                                  _currentIndex = _currentIndex + 1;
                                } else {}
                                frontCardOffset = Offset(0, 0);
                              },
                            );
                          },
                        ),
                      ],
                    )
                  : Center(
                      child: Text('No Items'),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
