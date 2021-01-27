// import 'dart:io';

import '../../providers/item_categories.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../helpers/image_input.dart';
import '../../providers/items.dart';
// import '../../providers/outfits.dart';
import '../../models/item.dart';
import '../../models/categories.dart';

class OutfitBuilder extends StatefulWidget {
  static const routeName = '/addOutfit';

  @override
  _OutfitBuilderState createState() => _OutfitBuilderState();
}

class _OutfitBuilderState extends State<OutfitBuilder> {
  Offset frontCardOffset = Offset(0, 0);
  int _currentIndex = 0;
  ItemCategory _currentCategory;
  List<ItemCategory> _categories;
  Map<ItemCategory, List<Item>> _items;
  List<Item> _selectedItems = [];

  @override
  void didChangeDependencies() {
    _items = Provider.of<Items>(context).items;
    _items.forEach((key, value) {
      _items[key] = [...value];
    });
    _categories = Provider.of<ItemCategories>(context).categories;
    _currentCategory = _categories.first;
    super.didChangeDependencies();
  }

  void _saveOutfit(List<Item> items) {
    // OutfitCategory category = ModalRoute.of(context).settings.arguments;
    // Provider.of<Outfits>(context, listen: false)
    //     .insertOutfit(category, items, null)
    //     .then(Navigator.of(context).pop);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => _Confirm(),
    ));
  }

  void _selectionHandler() {
    setState(() {
      if (frontCardOffset.dx > 150) {
        _selectedItems.add(_items[_currentCategory][_currentIndex]);
        _items[_currentCategory]
            .remove(_items[_currentCategory][_currentIndex]);
        _setCurrentCategory();
      } else if (frontCardOffset.dx < -150) {
        _currentIndex++;
        _setCurrentCategory();
      }
      frontCardOffset = Offset(0, 0);
    });
  }

  void _setCurrentCategory() {
    if (_currentIndex >= _items[_currentCategory].length) {
      try {
        _currentCategory =
            _categories[_categories.indexOf(_currentCategory) + 1];
        _currentIndex = 0;
      } catch (e) {
        _currentCategory = _categories.first;
        _currentIndex = 0;
      }
    }
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
            Container(
              // height: 50,
              // width: 300,
              child: Container(
                // height: 50,
                // width: 300,
                color: Theme.of(context).canvasColor,
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    underline: Container(),
                    isExpanded: true,
                    value: _currentCategory,
                    onChanged: (ItemCategory category) {
                      setState(() {
                        _currentCategory = category;
                        _currentIndex = 0;
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
              ),
            ),
            Expanded(
                child: _items[_currentCategory].length == 0
                    ? Center(
                        child: Text('No Items'),
                      )
                    : Stack(
                        children: [
                          Container(
                            color: Theme.of(context).canvasColor,
                          ),
                          Align(
                            child: Transform.translate(
                              offset: frontCardOffset,
                              child: Card(
                                elevation: 2,
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.file(
                                      _items[_currentCategory][_currentIndex]
                                          .image,
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
                            onPanEnd: (DragEndDetails details) =>
                                _selectionHandler(),
                          ),
                        ],
                      ))
          ],
        ),
      ),
    );
  }
}

class _Confirm extends StatefulWidget {
  @override
  __ConfirmState createState() => __ConfirmState();
}

class __ConfirmState extends State<_Confirm> {
  ImageInput _imageInput = ImageInput();
  void _addFeatureImage() {
    _imageInput.takePicture().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm'),
      ),
      body: Column(
        children: [
          _imageInput.image == null
              ? Container()
              : Image.file(_imageInput.image),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: RaisedButton(
              child: Text('Add Photo'),
              onPressed: _addFeatureImage,
            ),
          )
        ],
      ),
    );
  }
}
