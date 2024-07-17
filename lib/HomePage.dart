import 'package:flutter/material.dart';
import 'dart:math';
import 'todo.dart';
import 'todo_item.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> _todos = Todo.todoList();
  List<Todo> _filteredTodos = [];
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredTodos = _todos;
    _searchController.addListener(_filterTodos);
  }

  void _filterTodos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredTodos = _todos.where((todo) {
        return todo.todoText.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _addTodoItem(String title) {
    setState(() {
      _todos.add(Todo(
        id: Random().nextInt(1000).toString(),
        todoText: title,
      ));
      _filteredTodos = _todos;
    });
    _textController.clear();
  }

  void _toggleTodoItem(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _confirmDeleteTodoItem(BuildContext context, Todo todo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Task"),
          content: Text("Are you sure you want to delete this task?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteTodoItem(todo);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteTodoItem(Todo todo) {
    setState(() {
      _todos.remove(todo);
      _filteredTodos = _todos;
    });
  }

  void _showProfileOptions(BuildContext context) {
    String userEmail = 'prerna@gmail.com';
    String userName = 'Prerna Anand';
    int completedTasks = _todos.where((todo) => todo.isDone).length;
    int pendingTasks = _todos.length - completedTasks;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipOval(
                child: Image.network(
                  "https://cdn.pixabay.com/photo/2018/03/13/17/46/please-3223194_1280.jpg",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                userName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                userEmail,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              SizedBox(height: 20),
              Divider(thickness: 1),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Completed Tasks',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '$completedTasks',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.green),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pending Tasks',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '$pendingTasks',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text('Sign out'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => login()),
                  );
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Close",
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onMenuOptionSelected(String value) {
    // Implement navigation or functionality here based on value
    switch (value) {
      case 'Settings':
        break;
      case 'About':
        break;
      case 'Help':
        break;
      case 'Change Password':
        break;
      case 'Feedback':
        break;
    }
  }

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text('Add New Todo'),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration(
              labelText: 'Todo Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  _addTodoItem(_textController.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add Todo'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text('TODO APP', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => _showProfileOptions(context),
              child: ClipOval(
                child: Image.network(
                  "https://cdn.pixabay.com/photo/2018/03/13/17/46/please-3223194_1280.jpg",
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Prerna Anand"),
              accountEmail: Text("prerna@gmail.com"),
              currentAccountPicture: ClipOval(
                child: Image.network(
                  "https://cdn.pixabay.com/photo/2018/03/13/17/46/please-3223194_1280.jpg",
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notifications'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                _onMenuOptionSelected('Settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                _onMenuOptionSelected('About');
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help'),
              onTap: () {
                _onMenuOptionSelected('Help');
              },
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              onTap: () {
                _onMenuOptionSelected('Change Password');
              },
            ),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Feedback'),
              onTap: () {
                _onMenuOptionSelected('Feedback');
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Policy'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Todos',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTodos.length,
              itemBuilder: (context, index) {
                return TodoItem(
                  todo: _filteredTodos[index],
                  onToggle: _toggleTodoItem,
                  onDelete: (todo) => _confirmDeleteTodoItem(context, todo),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
