import 'package:flutter/material.dart';
import 'package:my_shopping_list/app/util/my_shopping_list_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('My shopping list'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          MyShoppingListTile(
            taskName: "I love you Alineczka",
            taskCompleted: true,
            onChanged: (p0) {},
          ),
          MyShoppingListTile(
            taskName: "I need you",
            taskCompleted: false,
            onChanged: (p0) {},
          ),
          MyShoppingListTile(
            taskName: "I need beer",
            taskCompleted: true,
            onChanged: (p0) {},
          ),
        ],
      ),
    );
  }
}
