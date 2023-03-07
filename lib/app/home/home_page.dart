import 'package:flutter/material.dart';
import 'package:my_shopping_list/app/util/dialog_box.dart';
import 'package:my_shopping_list/app/util/myshoppinglist_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

//text controller
final _controller = TextEditingController();

// list of myShoppingList tasks
class _HomePageState extends State<HomePage> {
  List myShoppingList = [
    ["Make", false],
    ["ToDo", false],
  ];

  // checkbox was tapped
  void checkBoxChanged(
    bool? value,
    int index,
  ) {
    setState(() {
      myShoppingList[index][1] = !myShoppingList[index][1];
    });
  }

  //save new task
  void saveNewTask() {
    setState(() {
      myShoppingList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

//createNewTask
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        title: const Text('My shopping list'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(
          Icons.add,
        ),
      ),
      body: ListView.builder(
        itemCount: myShoppingList.length,
        itemBuilder: (context, index) {
          return MyShoppingListTile(
            taskName: myShoppingList[index][0],
            taskCompleted: myShoppingList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
          );
        },
      ),
    );
  }
}
