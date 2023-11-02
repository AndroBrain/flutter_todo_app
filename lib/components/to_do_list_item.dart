import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoListItem extends StatelessWidget {
  final String name;
  final bool completed;
  Function(bool?)? onCompletedChanged;
  Function(BuildContext)? onDelete;

  ToDoListItem({
    super.key,
    required this.name,
    required this.completed,
    required this.onCompletedChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDelete,
              icon: Icons.delete,
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(16),
            )
          ],
        ),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Checkbox(value: completed, onChanged: onCompletedChanged),
                Text(
                  name,
                  style: TextStyle(
                      decoration: completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
