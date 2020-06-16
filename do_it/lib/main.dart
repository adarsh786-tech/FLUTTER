import 'package:do_it/ui/todolist.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.lightGreenAccent,
            title: Text('DO-IT', style: TextStyle(color: Colors.black45))),
        body: ToDoList(),
      ),
    );
  }
}
