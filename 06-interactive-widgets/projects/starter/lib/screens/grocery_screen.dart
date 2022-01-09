import 'package:flutter/material.dart';
import 'grocery_list_screen.dart';
import 'grocery_item_screen.dart';
import '../models/grocery_manager.dart';
import 'package:provider/provider.dart';
import 'empty_grocery_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _floatingButtonPressed(context);
        },
      ),
      body: buildGroceryScreen(),
    );
  }

  void _floatingButtonPressed(BuildContext context) {
    final manager = Provider.of<GroceryManager>(
      context,
      listen: false,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GroceryItemScreen(
          onCreate: (item) {
            manager.addItem(item);
            Navigator.pop(context);
          },
          onUpdate: (item) {},
        ),
      ),
    );
  }

  Widget buildGroceryScreen() {
    return Consumer<GroceryManager>(
      builder: (context, manager, child) {
        if (manager.groceryItems.isNotEmpty) {
          return GroceryListScreen(manager: manager);
        }

        return const EmptyGroceryScreen();
      },
    );
  }
}
