import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todolist_app/tasks.dart';  
import 'package:todolist_app/models/task.dart'; 
import 'package:todolist_app/widgets/task_item.dart';
import 'package:todolist_app/services/firestore.dart';

class TasksList extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getTasks(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final taskLists = snapshot.data!.docs;
        List<Task> taskItems = [];

        for (int index = 0; index < taskLists.length; index++) {
          DocumentSnapshot document = taskLists[index];
          String documentId = document.id;
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          DocumentSnapshot doc = snapshot.data!.docs[index];
          String id =document.id;
          String title = data['taskTitle'];
          String description = data['taskDesc'];
          DateTime date = (data['taskDate'] as Timestamp).toDate();
          String categoryString = data['taskCategory'] ;
          bool checked=( data['taskchecked'] as bool);
          Category category;
          switch (categoryString) {
            case 'Category.personal':
              category = Category.personal;
              break;
            case 'Category.work':
              category = Category.work;
              break;
            case 'Category.shopping':
              category = Category.shopping;
              break;
            default:
              category = Category.others;
          }

          Task task = Task.withId(
            id : id,
            title: title,
            description: description,
            date: date,
            category: category,
            checked : checked,
          );
          taskItems.add(task);
        }

        return ListView.builder(
          itemCount: taskItems.length,
          itemBuilder: (ctx, index) {
            return TaskItem(taskItems[index]);
          },
        );
      },
    );
  }
}

  /*final List<Task> tasks;

  TasksList({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (ctx, index) => TaskItem(tasks[index]),
    );
  }*/

