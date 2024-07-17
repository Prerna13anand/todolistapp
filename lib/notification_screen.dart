import 'package:flutter/material.dart';
import 'todo.dart';

class NotificationsScreen extends StatelessWidget {
  final List<Todo> todos;

  NotificationsScreen({required this.todos});

  @override
  Widget build(BuildContext context) {
    int completedTasks = todos.where((todo) => todo.isDone).length;
    int pendingTasks = todos.length - completedTasks;

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Completed Tasks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '$completedTasks',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            SizedBox(height: 20),
            Text(
              'Pending Tasks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '$pendingTasks',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
