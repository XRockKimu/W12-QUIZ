import 'package:flutter/material.dart';
import 'package:quiz/ui/groceries/grocery_form.dart';

import '../../data/mock_grocery_repository.dart';
import '../../models/grocery.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  var _groceryItems = dummyGroceryItems;

  void onCreate() async {
    // TODO-4 - Navigate to the form screen using the Navigator push [SC]
    final newGrocery = await Navigator.of(context).push<Grocery>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newGrocery != null) {
      setState(() {
        _groceryItems = [..._groceryItems, newGrocery];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
      //  Display groceries with an Item builder and  LIst Tile
      content = ListView.builder(
        itemCount: dummyGroceryItems.length,
        itemBuilder: (context, index) =>
            GroceryItem(grocery: dummyGroceryItems[index]),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: () => {}, icon: const Icon(Icons.add))],
      ),
      body: content,
    );
  }
}

class GroceryItem extends StatelessWidget {
  const GroceryItem({super.key, required this.grocery});

  final Grocery grocery;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(color: grocery.category.color, width: 15, height: 15),
      title: Text(grocery.name),
      trailing: Text(grocery.quantity.toString()),
    );
  }
}
