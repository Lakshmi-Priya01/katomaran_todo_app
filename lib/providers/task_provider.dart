import 'package:flutter/foundation.dart';
import '../models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  List<Task> get tasks => _tasks;

  void addTask(Task task) async {
    _tasks.add(task);
    notifyListeners();

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(task.id)
        .set(task.toMap());
  }

  void updateTask(Task task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  void deleteTask(String id) async {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(id)
        .delete();
  }

  void toggleComplete(String id) async {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index].isComplete = !_tasks[index].isComplete;
      notifyListeners();

      await _firestore
          .collection('users')
          .doc(uid)
          .collection('tasks')
          .doc(id)
          .update({'isComplete': _tasks[index].isComplete});
    }
  }

  Future<void> loadTasks() async {
    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .get();

    _tasks.clear();
    for (var doc in snapshot.docs) {
      _tasks.add(Task.fromMap(doc.data()));
    }
    notifyListeners();
  }
}

