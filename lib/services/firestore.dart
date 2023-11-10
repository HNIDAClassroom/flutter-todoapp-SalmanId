import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';
class FirestoreService{
final CollectionReference tasks= FirebaseFirestore.instance.collection('tasks');

Future<void> addTask( Task task)
{
  return FirebaseFirestore.instance.collection('tasks').add(
    {
      'taskTitle': task.title.toString(),
      'taskDesc': task.description.toString(),
      'taskDate':Timestamp.fromDate(task.date),
      'taskCategory': task.category.toString(),
      'taskchecked': task.checked,

    },
  );
}
Stream <QuerySnapshot> getTasks()
{
  final taskStream= tasks.snapshots();
  return taskStream;
}
  Future<void> deleteTaskById(String taskId) async {
    DocumentReference docRef = tasks.doc(taskId);
    return docRef.delete();
  }
Future<void> updateTaskCompletion(String taskId, bool isCompleted) async {
    DocumentReference docRef = tasks.doc(taskId);
    return docRef.update({'taskchecked': isCompleted});
  }


}