import 'package:flutter/material.dart';

import '../../models/item.dart';

class OutfitWidget extends StatelessWidget {
  final List<String> title;
  final List<Item> items;

  OutfitWidget(this.title, this.items);
  Widget _build() {
    if (items.length >= 4) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: Image.file(items[0].image)),
              Expanded(child: Image.file(items[1].image)),
            ],
          ),
          Row(
            children: [
              Expanded(child: Image.file(items[2].image)),
              Expanded(child: Image.file(items[3].image)),
            ],
          )
        ],
      );
    } else {
      return Image.file(items[0].image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(child: _build()),
    );
  }
}
