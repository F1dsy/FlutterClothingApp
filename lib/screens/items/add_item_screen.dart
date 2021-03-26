import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/item_categories.dart';
import '../../providers/items.dart';
import '../../helpers/image_input.dart';
import '../../widgets/slider.dart';
import '../../helpers/slider_labels.dart';

class AddItemScreen extends StatefulWidget {
  static const routeName = 'addItem';
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  @override
  void initState() {
    _takePicture();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  final imageInput = ImageInput();

  double temperateValue = 1;

  void _save() async {
    _formKey.currentState!.save();

    Navigator.of(context).pop();
  }

  void _takePicture() async {
    imageInput.takePicture().then((value) {
      if (!value) {
        Navigator.of(context).pop();
      } else {
        setState(() {});
      }
    });
  }

  // void _pickFromGallery() {
  //   imageInput.pickFromGallery().then((value) {
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
        actions: [IconButton(icon: Icon(Icons.done), onPressed: _save)],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Card(
              margin: const EdgeInsets.all(8.0),
              child: imageInput.image == null
                  ? null
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.file(imageInput.image!),
                    ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                items: Provider.of<ItemCategories>(context)
                    .categories
                    .map((category) => DropdownMenuItem(
                          child: Container(
                            margin: const EdgeInsets.only(left: 8.0),
                            child: Text(category.title),
                          ),
                          value: category,
                        ))
                    .toList(),
                value: ModalRoute.of(context)!.settings.arguments,
                onChanged: (dynamic _) {},
                onSaved: (dynamic category) {
                  Provider.of<Items>(context, listen: false)
                      .insertItem(category, imageInput.image!);
                },
              ),
            ),
            CustomSlider(
              value: temperateValue,
              onChanged: (val) {
                setState(() {
                  temperateValue = val;
                });
              },
              label: getSliderLabel(temperateValue),
              min: 0.0,
              max: 4.0,
              divisions: 4,
            ),
          ],
        ),
      ),
    );
  }
}
