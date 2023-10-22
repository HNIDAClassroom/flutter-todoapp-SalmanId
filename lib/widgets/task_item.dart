import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        // Vous pouvez personnaliser davantage l'apparence ici.
      ),
    );
  }
}
