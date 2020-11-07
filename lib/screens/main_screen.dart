import 'package:FlutterClothingApp/screens/add_item_category_screen.dart';
import 'package:flutter/material.dart';

import 'items_category_screen.dart';
import 'outfits_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> _pages = [
    OutfitsScreen(),
    ItemsCategoriesScreen(),
  ];

  var _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    final List<AppBar> _pageAppbars = [
      AppBar(
        title: const Text('Outfits'),
      ),
      AppBar(
        title: const Text('Items'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddItemCategoryScreen()),
                ).then((value) {
                  if (value) {
                    setState(() {});
                  }
                });
              }),
        ],
      ),
    ];
    return Scaffold(
      appBar: _pageAppbars[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox),
            label: 'Outfits',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: 'Items',
          )
        ],
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
          });
        },
        currentIndex: _selectedIndex,
      ),
      body: _pages[_selectedIndex],
    );
  }
}
