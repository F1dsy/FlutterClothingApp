import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/item_categories.dart';
import '../../providers/items.dart';
import '../../helpers/image_input.dart';

class AddItemScreen extends StatefulWidget {
  static const routeName = 'addItem';
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();

  final imageInput = ImageInput();

  void _save() async {
    _formKey.currentState.save();

    Provider.of<Items>(context, listen: false).fetchAndSetItems();
    Navigator.of(context).pop();
  }

  void _takePicture() async {
    imageInput.takePicture().then((value) {
      setState(() {});
    });
  }

  void _pickFromGallery() {
    imageInput.pickFromGallery().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
        actions: [IconButton(icon: Icon(Icons.done), onPressed: _save)],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: imageInput.image == null
                  ? null
                  : Image.file(imageInput.image),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton.icon(
                  label: Text('Camera'),
                  icon: Icon(Icons.camera_alt),
                  onPressed: _takePicture,
                ),
                FlatButton.icon(
                  label: Text('Gallery'),
                  icon: Icon(Icons.image),
                  onPressed: _pickFromGallery,
                )
              ],
            ),
            DropdownButtonFormField(
              items: Provider.of<ItemCategories>(context)
                  .categories
                  .map((e) => DropdownMenuItem(
                        child: Text(e.title),
                        value: e.title,
                      ))
                  .toList(),
              value: ModalRoute.of(context).settings.arguments,
              onChanged: (_) {},
              onSaved: (value) {
                Provider.of<Items>(context, listen: false)
                    .insertItem(value, imageInput.image.path);
              },
            ),
          ],
        ),
      ),
    );
  }
}
