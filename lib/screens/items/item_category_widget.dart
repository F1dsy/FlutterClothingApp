import 'package:flutter/material.dart';

import '../../models/categories.dart';

class ItemCategoryWidget extends StatelessWidget {
  final ItemCategory category;
  // final bool selectCategory;
  final bool selected;
  final Function toggle;
  final List list;

  ItemCategoryWidget(
    this.category,
    // this.selectCategory,
    this.selected,
    this.toggle,
    this.list,
  );

  void onTap(BuildContext context) {
    // if (selectCategory == true) {
    // Navigator.of(context).pop(category.title);
    // } else {
    Navigator.of(context).pushNamed('/item', arguments: category.title);
    // }
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = list.contains(category);

    return Card(
      child: ListTile(
        title: Text(category.title),
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
