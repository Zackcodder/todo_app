// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/new_model.dart';
import 'package:todo_app/providers/new_provider.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  final TextEditingController taskController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 9.0,
        shadowColor: Colors.amber,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'Todo App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 35),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Todo List',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Expanded(
              child: Consumer<NewTaskProvider>(
                builder: (context, taskProvider, child) {
                  return ListView.builder(
                    itemCount: taskProvider.tasks.length,
                    itemBuilder: (context, index) {
                      final task = taskProvider.tasks[index];
                      return Dismissible(
                        key: Key(task.title),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          // Temporarily store the deleted task
                          final deletedTask = task;

                          // Delete the task
                          taskProvider.deleteTask(index);

                          // Await some delay to allow the widget to be removed
                          Future.delayed(const Duration(microseconds: 100));

                          // Show SnackBar with undo option
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${task.title} deleted"),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () async {
                                  // Restore the deleted task
                                  // taskProvider.addTask(deletedTask.title);
                                  taskProvider.undoDelete();
                                },
                              ),
                            ),
                          );
                        },
                        background: Container(
                          margin: const EdgeInsets.only(
                              top: 15, left: 10, right: 10),
                          color: Colors.red,
                          padding: const EdgeInsets.only(right: 20),
                          alignment: Alignment.centerRight,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(15)),
                          margin: const EdgeInsets.only(
                              top: 15, left: 10, right: 10),
                          child: ListTile(
                            title: Text(
                              task.title,
                              style: TextStyle(
                                fontSize: 15,
                                decoration: task.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            //markign of task
                            leading: Checkbox(
                              value: task.isCompleted,
                              onChanged: (value) {
                                taskProvider.toggleTaskCompletion(index);
                              },
                            ),

                            ///edit task
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _showEditTaskDialog(context, task, index);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  ///adding new task dialog box
  _showAddTaskDialog(BuildContext context) {
    final TextEditingController taskController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(
              hintText: 'Enter task name',
            ),
          ),
          actions: [
            ///pop to concel and dialog dislog box
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),

            ///add new task button
            TextButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  Provider.of<NewTaskProvider>(context, listen: false)
                      .addTask(taskController.text);
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  Fluttertoast.showToast(
                    fontSize: 18,
                    toastLength: Toast.LENGTH_LONG,
                    backgroundColor: Colors.red.withOpacity(0.7),
                    msg: 'Task can not be  empty',
                    gravity: ToastGravity.CENTER,
                    textColor: Colors.white,
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  ///edit task dialog
  _showEditTaskDialog(BuildContext context, NewTaskModel task, int index) {
    final TextEditingController taskController =
        TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(
              hintText: 'Edit task name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  Provider.of<NewTaskProvider>(context, listen: false)
                      .editTask(index, taskController.text);
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
