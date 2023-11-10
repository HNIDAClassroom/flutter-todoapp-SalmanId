import 'package:flutter/material.dart';
import 'package:todolist_app/new_task.dart';
import 'package:todolist_app/tasks_list.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/services/firestore.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});
  
  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final FirestoreService firestoreService= FirestoreService();
  List<Task> _registeredTasks = [
  Task(
    title: 'Apprendre Flutter',
    description: 'Suivre le cours pour apprendre de nouvelles compétences',
    date: DateTime.now(),
    category: Category.work,
  ),
  Task(
    title: 'Faire les courses',
    description: 'Acheter des provisions pour la semaine',
    date: DateTime.now().subtract(Duration(days: 1)),
    category: Category.shopping,
  ),
  Task(
    title: 'Rediger un CR',
    description: '',
    date: DateTime.now().subtract(Duration(days: 2)),
    category: Category.personal,
  ),
  // Add more tasks with descriptions as needed
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: const Text('Tasks',
         style: TextStyle(
                  color: Colors.white, 
                  fontWeight:FontWeight.bold,
                  fontSize:30,
                  
                ),
        ),
        centerTitle: true,
       
        backgroundColor: Colors.black,
      ),
      body: TasksList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTaskOverlay,
        backgroundColor: Colors.black, // Background color of the round button
        child: Icon(Icons.add, color: Colors.white), // Icon color of the round button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Position du bouton flottant
    );
  }
  void _openAddTaskOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTask(onAddTask: _addTask),
    );
  }
  /*void _addTask(Task task) {
    setState(() {
    _registeredTasks.add(task);
  });*/
  void _addTask(Task task) {
    setState(() {
      //_registeredTasks.add(task);
      firestoreService.addTask(task);
      Navigator.pop(context);
    });



}

 


}