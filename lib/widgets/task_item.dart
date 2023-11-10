import 'package:flutter/material.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/services/firestore.dart';
import 'package:intl/intl.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  final FirestoreService firestoreService = FirestoreService();

  TaskItem(this.task);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  void _deleteTask(BuildContext context) async {
    await widget.firestoreService.deleteTaskById(widget.task.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color cardColor = widget.task.checked ? Colors.grey[200] ?? Colors.grey[200]! : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Espace vertical entre les TaskItem
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.grey, width: 2.0),
        ),
        child: ListTile(
          title: Text(
            widget.task.title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.amber, // Gold color
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.task.description}',
                style: TextStyle(
                  color: Colors.black, // Black color
                ),
              ),
              Text(
                '${_dateFormat.format(widget.task.date.toLocal())}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Black color
                ),
              ),
              Text(
                ' ${widget.task.category.toString()}',
                style: TextStyle(
                  color: Colors.black, // Black color
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: widget.task.checked,
                onChanged: (value) {
                  // Mettez à jour l'état de la case à cocher uniquement si la tâche n'est pas déjà cochée
                  if (!widget.task.checked) {
                    widget.firestoreService.updateTaskCompletion(widget.task.id, value ?? true);
                  }
                },
                activeColor: Colors.green, // Green color for checkbox
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red), // Red color for delete icon
                onPressed: () => _deleteTask(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
