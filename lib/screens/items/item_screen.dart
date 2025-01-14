import 'package:fabrics/models/item_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/categories.dart';
import '../../models/item.dart';
import '../../providers/item_categories.dart';
import '../../providers/items.dart';
import '../../helpers/image_input.dart';
import '../../widgets/slider.dart';
// import '../../helpers/slider_labels.dart';

class ItemScreen extends StatefulWidget {
  static const routeName = '/item';
  static const routeNameAddItem = '/add-item';

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  ItemCategory? category;
  Item? item;
  double sliderValue = 2;
  bool isAddItem = false;
  ImageInput _imageInput = ImageInput();

  void _takePicture() async {
    _imageInput.takePicture().then((value) {
      if (!value) {
        Navigator.of(context).pop();
      } else {
        setState(() {});
      }
    });
  }

  void addItem() {
    Provider.of<Items>(context, listen: false)
        .insertItem(category!, _imageInput.image!, sliderValue);
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    isAddItem = ModalRoute.of(context)!.settings.name == '/add-item';
    if (isAddItem) {
      _takePicture();
      category = ModalRoute.of(context)!.settings.arguments as ItemCategory;
    } else {
      item = ModalRoute.of(context)!.settings.arguments as Item;
      sliderValue = item!.temperature.index.toDouble();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          height: double.infinity,
          color: Colors.transparent,
          alignment: Alignment.centerLeft,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: isAddItem
                    ? [
                        CloseButton(),
                        IconButton(icon: Icon(Icons.done), onPressed: addItem),
                      ]
                    : [
                        BackButton(),
                      ],
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: isAddItem
                  ? (_imageInput.image != null
                      ? Image.file(_imageInput.image!)
                      : null)
                  : Hero(
                      tag: item!,
                      child: Image.file(item!.image),
                    ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<ItemCategory>(
                value: category ?? item!.category,
                onChanged: (value) {
                  setState(() {
                    category = value;
                    if (!isAddItem) {
                      Provider.of<Items>(context, listen: false)
                          .updateItem(item: item!, itemCategory: value);
                    }
                  });
                },
                isExpanded: true,
                items: Provider.of<ItemCategories>(context)
                    .categories
                    .map(
                      (category) => DropdownMenuItem<ItemCategory>(
                        value: category,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(category.title),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text('Temperature'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: CustomSlider(
                    value: sliderValue,
                    onChanged: (val) {
                      setState(() {
                        sliderValue = val;
                        if (!isAddItem) {
                          Provider.of<Items>(context, listen: false).updateItem(
                              item: item!,
                              temperature: Temperature.values[val.toInt()]);
                        }
                      });
                    },
                    divisions: 4,
                    max: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
