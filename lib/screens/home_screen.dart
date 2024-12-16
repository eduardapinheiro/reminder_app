import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/task.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks(); // Carrega tarefas salvas ao iniciar
  }

  void loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskList = prefs.getStringList('tasks');
    if (taskList != null) {
      setState(() {
        tasks = taskList.map((task) => Task.fromMap(jsonDecode(task))).toList();
      });
    }
  }

  void saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskList = tasks.map((task) => jsonEncode(task.toMap())).toList();
    prefs.setStringList('tasks', taskList);
  }

  void addTask(String title) {
    setState(() {
      tasks.add(Task(title: title));
    });
    saveTasks();
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    saveTasks();
  }

  void toggleTaskCompletion(int index, bool? value) {
    setState(() {
      tasks[index].isCompleted = value ?? false;
    });
    saveTasks();
  }

  void showAddTaskDialog() {
    TextEditingController taskController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'New Task',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          content: TextField(
            controller: taskController,
            decoration: InputDecoration(
              hintText: 'Enter task title',
              hintStyle: TextStyle(color: Colors.grey[400]),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 10.0,
              ),
            ),
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  addTask(taskController.text);
                }
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[300],
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${tasks.length} Tasks",
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            Text(
              "My Reminders",
              style: TextStyle(
                  color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: tasks.isEmpty
          ? Center(
        child: Text(
          'No tasks added yet!',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(tasks[index].title),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              removeTask(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Task removed')),
              );
            },
            child: TaskTile(
              task: tasks[index],
              onChanged: (value) {
                toggleTaskCompletion(index, value);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTaskDialog,
        backgroundColor: Colors.pink[300],
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
