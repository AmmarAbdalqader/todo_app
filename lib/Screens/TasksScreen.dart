import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Constants/myColors.dart';
import 'package:todo_app/Models/Task_Data.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final TextEditingController addTaskCon = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  // }

  Widget AllPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 60, left: 35, right: 35, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                child: Icon(
                  Icons.list,
                  color: mainColor,
                  size: 40,
                ),
                backgroundColor: white,
                radius: 30,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Todoey',
                style: TextStyle(
                  color: white,
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${Provider.of<TaskData>(context).tasksCount} ' +
                    '${Provider.of<TaskData>(context).tasksCount == 1 ? 'Task' : 'Tasks'}',
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Consumer<TaskData>(
              builder: (context, taskData, child) {
                // Instead of Provider.of<TaskData>(context) use taskData in Consume Widget
                return ListView.builder(
                  itemCount: taskData.tasksCount,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onLongPress: () {
                          taskData.deleteTask(taskData.tasks[index]);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                taskData.tasks[index].name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                  decoration: taskData.tasks[index].isChecked
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                            Checkbox(
                              fillColor: MaterialStateProperty.all(mainColor),
                              value: taskData.tasks[index].isChecked,
                              onChanged: (value) {
                                taskData.updateTask(taskData.tasks[index]);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: AllPage(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Task',
        backgroundColor: mainColor,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                color: Color(0xff757575),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Add Task',
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Input Here',
                        ),
                        controller: addTaskCon,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (addTaskCon.text.trim().isNotEmpty) {
                                  Provider.of<TaskData>(context, listen: false)
                                      .addTask(addTaskCon.text.trim());
                                  Navigator.pop(context);
                                  addTaskCon.clear();
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Add',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              style:
                                  ElevatedButton.styleFrom(primary: mainColor),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
