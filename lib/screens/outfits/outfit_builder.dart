import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../providers/items.dart';
import '../../providers/outfits.dart';
// import '../providers/item_categories.dart';
import '../../models/item.dart';

class OutfitBuilder extends StatefulWidget {
  static const routeName = '/addOutfit';

  @override
  _OutfitBuilderState createState() => _OutfitBuilderState();
}

class _OutfitBuilderState extends State<OutfitBuilder> {
  GlobalKey _appBar = GlobalKey();
  Offset frontCardOffset = Offset(0, 0);
  int _currentIndex = 0;
  final List<Item> _selectedItems = [];

  void _saveOutfit(List<Item> items) {
    String category = ModalRoute.of(context).settings.arguments;
    Provider.of<Outfits>(context, listen: false)
        .insertOutfit([category], items);
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
        height:
            MediaQuery.of(context).size.height - AppBar().preferredSize.height,
        child: FutureBuilder(
          future: Provider.of<Items>(context, listen: false).fetchAndSetItems(),
          builder: (context, snapshot) => Consumer<Items>(
            builder: (context, data, _) {
              final _items = data.items;

              return Column(
                children: [
                  Expanded(
                    child: Container(
                      child: StaggeredGridView.countBuilder(
                        crossAxisCount: 3,
                        itemBuilder: (context, i) => Card(
                          child: Image.file(
                            File(_selectedItems[i].imageURL),
                          ),
                        ),
                        itemCount: _selectedItems.length,
                        staggeredTileBuilder: (_) => StaggeredTile.fit(1),
                      ),
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
                                      child: Image.file(
                                        File(_items[_currentIndex].imageURL),
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
                                          frontCardOffset.dy +
                                              details.delta.dy);
                                    },
                                  );
                                },
                                onPanEnd: (DragEndDetails details) {
                                  setState(
                                    () {
                                      if (frontCardOffset.dx > 150) {
                                        _selectedItems
                                            .add(_items[_currentIndex]);
                                        _currentIndex = _currentIndex + 1;
                                        print(_currentIndex);
                                        print(_selectedItems);
                                      } else if (frontCardOffset.dx < -150) {
                                        _currentIndex = _currentIndex + 1;
                                      } else {
                                        print(false);
                                      }
                                      frontCardOffset = Offset(0, 0);
                                    },
                                  );
                                },
                              ),
                            ],
                          )
                        : Center(
                            child: Text('Empty'),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
