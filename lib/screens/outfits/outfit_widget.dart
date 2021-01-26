import 'package:flutter/material.dart';

import '../../models/outfit.dart';
import '../../widgets/show_image_dialog.dart';

class OutfitWidget extends StatelessWidget {
  final Outfit outfit;
  final bool selectable;
  final Function(Outfit) toggleSelected;
  final List list;

  OutfitWidget(
    this.outfit,
    this.selectable,
    this.toggleSelected, [
    this.list,
  ]);

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
    bool isSelected = list == null ? false : list.contains(outfit);
    return Container(
      child: Card(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: _build(),
            ),
            Positioned.fill(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      !selectable
                          ? showImageDialog(context,
                              outfit.items.map((e) => e.image).toList())
                          : toggleSelected(outfit);
                    },
                    onLongPress: () => toggleSelected(outfit),
                  )),
            ),
            Offstage(
              offstage: !selectable,
              child: IgnorePointer(
                child: Checkbox(
                  value: isSelected,
                  onChanged: null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
