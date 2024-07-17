class Todo {
  String id;
  String todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> todoList() {
    return [
      Todo(
        id: '01',
        todoText: 'Morning update',
        isDone: true,
      ),
      Todo(
        id: '02',
        todoText: 'Buy Shirts',
        isDone: true,
      ),
      Todo(
        id: '03',
        todoText: 'Morning Walk',
        isDone: true,
      ),
      Todo(
        id: '04',
        todoText: 'Go to mall',
        isDone: false,
      ),
      Todo(
        id: '05',
        todoText: 'Go to doctor',
        isDone: true,
      ),
      Todo(
        id: '06',
        todoText: 'Morning Alarm',
        isDone: false,
      ),
      Todo(
        id: '07',
        todoText: 'Laptop Update',
        isDone: true,
      ),
      Todo(
        id: '08',
        todoText: 'Google Meet',
        isDone: false,
      ),
    ];
  }
}