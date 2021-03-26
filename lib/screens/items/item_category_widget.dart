import 'package:flutter/material.dart';

import '../../models/categories.dart';

class ItemCategoryWidget extends StatelessWidget {
  final ItemCategory? category;
  final Function toggle;
  final bool selected;
  final List<ItemCategory> list;

  ItemCategoryWidget(
    this.category,
    this.toggle,
    this.selected,
    this.list,
  );

  void onTap(BuildContext context) {
    Navigator.of(context).pushNamed('/item', arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = list.contains(category);

    return Card(
      child: ListTile(
        title: Text(category!.title),
        onTap: () {
          selected ? toggle(category) : onTap(context);
        },
        onLongPress: () => toggle(category),
        trailing: Offstage(
          offstage: !selected,
          child: Checkbox(
            value: isSelected,
            onChanged: (_) {},
          ),
        ),
      ),
    );
  }
}
