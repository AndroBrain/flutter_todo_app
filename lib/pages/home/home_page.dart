import 'package:flutter/material.dart';
import 'package:todo_app/components/dialog_add_to_do_item.dart';
import 'package:todo_app/data/database.dart';

import '../../components/to_do_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _addTaskController = TextEditingController();
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    db.initData();
    super.initState();
  }


  void checkboxChanged(int index, bool? value) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList.toList()[index][1];
      db.updateToDoList();
    });
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogAddToDoItem(
          controller: _addTaskController,
          onConfirm: saveNewTask,
          onCancel: () {
            _addTaskController.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_addTaskController.text, false]);
      db.updateToDoList();
      _addTaskController.clear();
    });
    Navigator.of(context).pop();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      db.updateToDoList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .surface,
      appBar: AppBar(
        title: Text("TO DO"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoListItem(
            name: db.toDoList[index][0],
            completed: db.toDoList[index][1],
            onCompletedChanged: (value) => checkboxChanged(index, value),
            onDelete: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => createNewTask(),
      ),
    );
  }
}
