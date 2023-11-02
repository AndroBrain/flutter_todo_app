import 'package:hive_flutter/hive_flutter.dart';

const dbName = "taskBox";
const _dbListName = "TASKS";

class ToDoDatabase {
  final _myBox = Hive.box(dbName);

  List toDoList = [];

  void initData() {
    var data = _myBox.get(_dbListName);
    if (data == null) {
      toDoList = [
        ["Add your first task", false],
        ["Swipe left to delete", false],
      ];
    } else {
      toDoList = data;
    }
  }

  void updateToDoList() {
    _myBox.put(_dbListName, toDoList);
  }
}
