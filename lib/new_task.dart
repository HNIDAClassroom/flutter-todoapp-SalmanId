import 'package:flutter/material.dart';
import 'package:todolist_app/tasks.dart';  
import 'package:todolist_app/models/task.dart'; 
import 'package:intl/intl.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key, required this.onAddTask});
  final void Function(Task task) onAddTask;
  @override
  State<NewTask> createState(){
    return _NewTaskState();
    }
}

class _NewTaskState extends State<NewTask> {
  Category _selectedCategory = Category.personal;
  final _titleController = TextEditingController();
  final _descriptionController=TextEditingController();
  DateTime _selectedDate = DateTime.now();
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
  margin: EdgeInsets.all(16.0),
  padding: EdgeInsets.all(16.0),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3),
      ),
    ],
  ),
  child: Form(
    child: Column(
      children: [
        DropdownButton<Category>(
          value: _selectedCategory,
          items: Category.values.map((category) => DropdownMenuItem<Category>(
            value: category,
            child: Text(category.name.toUpperCase()),
          )).toList(),
          onChanged: (value) {
            if (value == null) {
              return;
            }
            setState(() {
              _selectedCategory = value;
            });
          },
        ),
        SizedBox(height: 16.0), // Espace entre le DropdownButton et le TextField
        TextField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        SizedBox(height: 16.0), // Espace entre le TextField et le prochain widget
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        SizedBox(height: 16.0), // Espace entre le TextField et le prochain widget
        Row(
          children: [
            Text("Date: ${DateFormat('dd-MM-yyyy').format(_selectedDate)}"), // Affiche la date sélectionnée
            TextButton(
              onPressed: _selectDate,
              child: Text('Select Date'),
            ),
          ],
        ),
        SizedBox(height: 16.0), // Espace entre le Row et le ElevatedButton
        ElevatedButton(
          onPressed: _submitTaskData,
          child: Text('Save'),
        ),
      ],
    ),
  ),
);

  } 
    void _selectDate() async {
    DateTime pickedDate = (await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    )) ?? DateTime.now();

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

   void _submitTaskData() {
    
    if (_titleController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text('Merci de saisir le titre de la tâche à ajouter dans la liste'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );

      return;
    }
    widget.onAddTask(
      Task(title: _titleController.text,description: _descriptionController.text,date: _selectedDate,category:_selectedCategory)
      );
    
}
}