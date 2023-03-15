import 'package:hive_flutter/hive_flutter.dart';

class MyShoppingListDataBase {
  List myShoppingList = [];

// reference our box

  final _myBox = Hive.box('mybox');

// run this metod if this is the first time ever opening this app
  void createInitialData() {
    myShoppingList = [
      ["Make Tutorial", false],
      ["Do Excerise", false],
    ];
  }

  //load the data from database

  void loadData() {
    myShoppingList = _myBox.get("MyShoppingList");
  }

  //update the database
  void updateDataBase() {
    _myBox.put("MyShoppingList", myShoppingList);
  }
}
