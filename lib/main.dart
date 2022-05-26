import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Models/Task_Data.dart';
import 'package:todo_app/Screens/TasksScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TasksScreen(),
      ),
    );
  }
}
