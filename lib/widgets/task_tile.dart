import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(bool?) onChanged;

  TaskTile({required this.task, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: onChanged,
        activeColor: Colors.pink[300],
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
    );
  }
}
