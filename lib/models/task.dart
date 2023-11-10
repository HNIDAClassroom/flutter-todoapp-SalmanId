import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { personal, work, shopping, others }
class Task{
  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  }) : id = uuid.v4(),checked = false;
  Task.withId({
    required this.id,
    required this.title,
    required this.description,  
    required this.date,
    required this.category,
    required this.checked,
    
  }) ;
  

  final String id;
  final String title;
  final String  description;
  final DateTime date;
  final Category category;
  final bool checked ;
}
