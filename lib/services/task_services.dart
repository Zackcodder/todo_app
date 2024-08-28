import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:http/http.dart' as http;

class TaskServices {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  ///get list of task
  Future<List<Task>> getTaskList() async {
    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      var response = await http.get(
        Uri.parse('$baseUrl/todos'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('e chock sha');
        List<dynamic> taskListJson = responseData;
        print(taskListJson);
        print('hmmm');
        List<Task> tasksList =
            taskListJson.map((json) => Task.fromJson(json)).toList();
        print('ahahahahah');
        return tasksList;
      } else {
        // Handle HTTP error
        throw Exception('Failed to load task list');
      }
    } catch (error) {
      // Handle any other errors
      throw Exception('Failed to task list: $error');
    }
  }

  // Add a new task
  Future<Task> addTask(Task task) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode(task.toJson());

    try {
      var response = await http.post(
        Uri.parse('$baseUrl/todos'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 201) {
        return Task.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to add task');
      }
    } catch (error) {
      throw Exception('Error adding task: $error');
    }
  }

  // Delete a task
  deleteTask(int id) async {
    final headers = {'Content-Type': 'application/json', 'Mode': 'delete'};

    try {
      var response = await http.delete(
        Uri.parse('$baseUrl/todos/$id'),
        headers: headers,
      );
      print('res from delete call ${response.statusCode}');

      if (response.statusCode == 200) {
        print('res from detle ${response.body}');
        Fluttertoast.showToast(
          fontSize: 18,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red.withOpacity(0.7),
          msg: 'Task Deleted',
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
        );
        print('deleted successfully');
        return true;
      } else {
        throw Exception('Failed to delete task');
      }
    } catch (error) {
      throw Exception('Error deleting task: $error');
    }
  }

  // Toggle task completion
  toggleComplete(Task task) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode(task.toJson());

    try {
      var response = await http.put(
        Uri.parse('$baseUrl/todos/${task.id}'),
        headers: headers,
        body: body,
      );
      print('res from toggle ${response.statusCode}');

      if (response.statusCode == 200) {
        print('res from toggle ${response.body}');
        Fluttertoast.showToast(
          fontSize: 18,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red.withOpacity(0.7),
          msg: 'Done',
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
        );
        return true;
      } else {
        throw Exception('Failed to update task');
      }
    } catch (error) {
      throw Exception('Error updating task: $error');
    }
  }
}
