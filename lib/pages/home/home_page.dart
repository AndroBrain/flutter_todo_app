import 'package:flutter/material.dart';
import 'package:todo_app/components/dialog_add_to_do_item.dart';

import '../../components/to_do_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _addTaskController = TextEditingController();

  List toDoList = [
    ["Complete app", false],
    ["Do exercise", false],
  ];

  void checkboxChanged(int index, bool? value) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
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
      toDoList.add([_addTaskController.text, false]);
      _addTaskController.clear();
    });
    Navigator.of(context).pop();
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
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
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoListItem(
            name: toDoList[index][0],
            completed: toDoList[index][1],
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
