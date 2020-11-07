import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item_categories.dart';

class AddItemCategoryScreen extends StatefulWidget {
  static const routeName = '/addItemCategory';
  @override
  _AddItemCategoryScreenState createState() => _AddItemCategoryScreenState();
}

class _AddItemCategoryScreenState extends State<AddItemCategoryScreen> {
  final _formKey = GlobalKey<FormState>();

  void _save() async {
    _formKey.currentState.save();
    Provider.of<ItemCategories>(context, listen: false).fetchAndSetCategories();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
        actions: [IconButton(icon: Icon(Icons.done), onPressed: _save)],
      ),
      body: Form(
        key: _formKey,
        child: TextFormField(
          onSaved: (value) {
            Provider.of<ItemCategories>(context, listen: false)
                .insertCategory(value);
          },
        ),
      ),
    );
  }
}
