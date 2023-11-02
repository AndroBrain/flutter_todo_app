import 'package:flutter/material.dart';

class DialogAddToDoItem extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onConfirm;
  VoidCallback onCancel;

  DialogAddToDoItem({super.key, required this.controller, required this.onConfirm, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Type in the task name"),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(onPressed: onCancel, child: Text("Cancel")),
        FilledButton(onPressed: onConfirm, child: Text("Add")),
      ],

    );
  }
}
