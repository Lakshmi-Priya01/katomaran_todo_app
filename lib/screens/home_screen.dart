import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/task_card.dart';
import 'task_edit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do Tasks"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // 🔐 You can add logout logic later here
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ➕ Navigate to add task screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TaskEditScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: tasks.isEmpty
          ? const Center(
        child: Text(
          "No tasks yet. Tap + to add.",
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskCard(
            task: task,
            onToggleComplete: () =>
                taskProvider.toggleComplete(task.id),
            onDelete: () => taskProvider.deleteTask(task.id),
          );
        },
      ),
    );
  }
}



