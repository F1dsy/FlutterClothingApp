import 'package:flutter/material.dart';

import '../../models/item.dart';
import '../../widgets/show_image_dialog.dart';

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
                  child: Image.file(item.image),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = list.contains(item);

    return Container(
        child: Card(
      child: Stack(
        children: [
          ClipRRect(
            child: Image.file(
              item.image,
              cacheWidth: 360,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          Positioned.fill(
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    !selectable
                        ? showImageDialog(context, [item.image])
                        : toggleSelected(item);
                  },
                  onLongPress: () => toggleSelected(item),
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
    ));
  }
}
