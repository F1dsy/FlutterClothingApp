import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/item.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  final bool selectable;
  final Function toggleSelected;
  final List list;
  ItemWidget(this.item, this.selectable, this.toggleSelected, this.list);

  void showImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.file(File(item.image)),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = list.contains(item);

    return Container(
      child: InkWell(
        onTap: () {
          !selectable ? showImage(context) : toggleSelected(item);
        },
        onLongPress: () => toggleSelected(item),
        child: Card(
          child: Stack(
            children: [
              Image.file(
                File(item.image),
                cacheWidth: 520,
              ),
              // Text(item.image.path),
              Offstage(
                offstage: !selectable,
                child: Checkbox(
                  value: isSelected,
                  onChanged: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
