import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/item.dart';

class ItemWidget extends StatefulWidget {
  final Item item;
  final bool selectable;
  final Function toggleSelected;
  ItemWidget(this.item, this.selectable, this.toggleSelected);

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  bool isSelected = false;

  void showImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.file(File(widget.item.imageURL)),
                ),
              ),
            ));
  }

  void toggleSelected() {
    widget.toggleSelected(widget.item);
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          !widget.selectable ? showImage(context) : toggleSelected();
        },
        onLongPress: toggleSelected,
        child: Card(
          child: Stack(
            children: [
              Image.file(
                File(widget.item.imageURL),
              ),
              Offstage(
                offstage: !widget.selectable,
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
