import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todo_task.dart';

class FirestoreService {
  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  // Real-time stream of user-specific tasks
  Stream<List<TodoTask>> getTasksStream(String userId) {
    return _tasksCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => TodoTask.fromFirestore(doc)).toList();
    });
  }

  // CREATE
  Future<String> addTask({
    required String title,
    required String description,
    required String userId,
  }) async {
    try {
      final now = DateTime.now();
      final docRef = await _tasksCollection.add({
        'title': title.trim(),
        'description': description.trim(),
        'isCompleted': false,
        'userId': userId,
        'createdAt': Timestamp.fromDate(now),
        'updatedAt': Timestamp.fromDate(now),
      });
      return docRef.id;
    } catch (e) {
      throw 'Failed to add task: $e';
    }
  }

  // UPDATE
  Future<void> updateTask({
    required String taskId,
    required String title,
    required String description,
    bool? isCompleted,
  }) async {
    try {
      final updateData = <String, dynamic>{
        'title': title.trim(),
        'description': description.trim(),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      };
      if (isCompleted != null) {
        updateData['isCompleted'] = isCompleted;
      }
      await _tasksCollection.doc(taskId).update(updateData);
    } catch (e) {
      throw 'Failed to update task: $e';
    }
  }

  // TOGGLE STATUS
  Future<void> toggleTaskStatus({
    required String taskId,
    required bool isCompleted,
  }) async {
    try {
      await _tasksCollection.doc(taskId).update({
        'isCompleted': isCompleted,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw 'Failed to update task status: $e';
    }
  }

  // DELETE
  Future<void> deleteTask(String taskId) async {
    try {
      await _tasksCollection.doc(taskId).delete();
    } catch (e) {
      throw 'Failed to delete task: $e';
    }
  }
}
