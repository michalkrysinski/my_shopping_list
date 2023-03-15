import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_shopping_list/app/data/database.dart';

import 'package:my_shopping_list/app/util/dialog_box.dart';
import 'package:my_shopping_list/app/util/myshoppinglist_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// reference the hive box
  final _myBox = Hive.box('mybox');
  MyShoppingListDataBase db = MyShoppingListDataBase();

  @override
  void initState() {
    //if this is the first time ever openinng the app, then create default data
    if (_myBox.get("MyShoppingList") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

//text controller
  final _controller = TextEditingController();

  // checkbox was tapped
  void checkBoxChanged(
    bool? value,
    int index,
  ) {
    setState(() {
      db.myShoppingList[index][1] = !db.myShoppingList[index][1];
    });
    db.updateDataBase();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.myShoppingList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
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
      },
    );
  }

//delete task
  void deleteTask(int index) {
    setState(
      () {
        db.myShoppingList.removeAt(index);
      },
    );
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200],
      appBar: AppBar(
        title: const Text('My shopping list'),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: ListView.builder(
        itemCount: db.myShoppingList.length,
        itemBuilder: (context, index) {
          return MyShoppingListTile(
            taskName: db.myShoppingList[index][0],
            taskCompleted: db.myShoppingList[index][1],
            onChanged: (value) => checkBoxChanged(
              value,
              index,
            ),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
