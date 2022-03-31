import 'package:flutter/material.dart';

import '../components/grocery_tile.dart';
import '../models/models.dart';
import 'grocery_item_screen.dart';

class GroceryListScreen extends StatelessWidget {
  final GroceryManager manager;

  const GroceryListScreen({
    Key? key,
    required this.manager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groceryItems = manager.groceryItems;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final item = groceryItems[index];
          // TODO 28
          // TODO 27
          return InkWell(
            key: Key(item.id),
            child: GroceryTile(
              key: Key(item.id),
              item: groceryItems[index],
              onComplete: (change) {
                if (change != null) {
                  manager.completeItem(index, change);
                }
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroceryItemScreen(
                    originalItem: item,
                    onCreate: (item) {},
                    onUpdate: (item) {
                      manager.updateItem(item, index);
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
        itemCount: groceryItems.length,
      ),
    );
  }
}
