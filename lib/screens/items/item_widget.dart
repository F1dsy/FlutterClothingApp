import 'package:flutter/material.dart';

import '../../models/item.dart';
// import '../../widgets/show_image_dialog.dart';
import 'item_screen.dart';

class ItemWidget extends StatelessWidget {
  final Item item;
  final bool selectable;
  final Function(Item) toggleSelected;
  final List? list;
  ItemWidget(this.item, this.toggleSelected,
      [this.selectable = false, this.list]);

  @override
  Widget build(BuildContext context) {
    bool isSelected = list == null ? false : list!.contains(item);

    return Container(
        child: Card(
      child: Stack(
        children: [
          ClipRRect(
            child: Hero(
              tag: item,
              child: Image.file(
                item.image,
                cacheWidth: 360,
              ),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          Positioned.fill(
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    !selectable
                        ? Navigator.of(context, rootNavigator: true)
                            .pushNamed(ItemScreen.routeName, arguments: item)
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
