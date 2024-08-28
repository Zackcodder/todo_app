import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/providers/new_provider.dart';

void main() {
  group('TaskProvider', () {
    late NewTaskProvider taskProvider;

    setUp(() {
      taskProvider = NewTaskProvider();
    });

    test('Adding a task increases the length of the task list', () {
      taskProvider.addTask('New Task');
      expect(taskProvider.tasks.length, 1);
    });

    test('Deleting a task decreases the length of the task list', () {
      taskProvider.addTask('Task 1');
      taskProvider.addTask('Task 2');
      taskProvider.deleteTask(0);
      expect(taskProvider.tasks.length, 1);
    });

    test('Undoing a deletion restores the deleted task', () {
      taskProvider.addTask('Task 1');
      taskProvider.deleteTask(0);
      expect(taskProvider.tasks.length, 0);
      
      taskProvider.undoDelete();
      expect(taskProvider.tasks.length, 1);
      expect(taskProvider.tasks[0].title, 'Task 1');
    });
  });
}
