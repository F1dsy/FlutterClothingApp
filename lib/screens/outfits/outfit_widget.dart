import 'package:flutter/material.dart';

import '../../models/outfit.dart';

class OutfitWidget extends StatelessWidget {
  final Outfit outfit;
  final bool selectable;
  final Function toggleSelected;
  final List list;

  OutfitWidget(this.outfit, this.selectable, this.toggleSelected, this.list);

  void showImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: ListView(
                    children: outfit.items
                        .map(
                          (item) => Image.file(item.image),
                        )
                        .toList(),
                    shrinkWrap: true,
                  ),
                ),
              ),
            ));
  }

  Widget _build() {
    if (outfit.items.length >= 4) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: Image.file(outfit.items[0].image)),
              Expanded(child: Image.file(outfit.items[1].image)),
            ],
          ),
          Row(
            children: [
              Expanded(child: Image.file(outfit.items[2].image)),
              Expanded(child: Image.file(outfit.items[3].image)),
            ],
          )
        ],
      );
    } else {
      return Image.file(outfit.items[0].image);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = list.contains(outfit);
    return Container(
      child: Card(
        child: Stack(
          children: [
            ClipRRect(
              child: _build(),
            ),
            Positioned.fill(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      !selectable ? showImage(context) : toggleSelected(outfit);
                    },
                    onLongPress: () => toggleSelected(outfit),
                  )),
            ),
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
    );
  }
}
