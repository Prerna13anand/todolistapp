import 'package:flutter/material.dart';
import 'todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onToggle;
  final Function(Todo) onDelete;

  const TodoItem({
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (value) {
            onToggle(todo);
          },
        ),
        title: Text(
          todo.todoText,
          style: TextStyle(
            decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            onDelete(todo);
          },
        ),
      ),
    );
  }
}
