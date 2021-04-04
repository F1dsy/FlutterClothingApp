import 'package:fabrics/models/item_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/categories.dart';
// import '../../models/item_data.dart';
import '../../models/item.dart';
import '../../providers/item_categories.dart';
import '../../providers/items.dart';
// import '../../helpers/image_input.dart';
import '../../widgets/slider.dart';
// import '../../helpers/slider_labels.dart';

class ItemScreen extends StatefulWidget {
  static const routeName = '/item';

  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  ItemCategory? category;
  late Item item;
  late double sliderValue;

  @override
  void didChangeDependencies() {
    item = ModalRoute.of(context)!.settings.arguments as Item;
    sliderValue = item.temperature.index.toDouble();
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
              child: BackButton(),
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
              child: Image.file(item.image),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<ItemCategory>(
                value: category ?? item.category,
                onChanged: (value) {
                  Provider.of<Items>(context, listen: false)
                      .updateItem(item: item, itemCategory: value);
                  setState(() {
                    category = value;
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
                        Provider.of<Items>(context, listen: false).updateItem(
                            item: item,
                            temperature: Temperature.values[val.toInt()]);
                        sliderValue = val;
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
