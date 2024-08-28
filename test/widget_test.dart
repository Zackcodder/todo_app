// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/providers/new_provider.dart';
import 'package:todo_app/screens/new_home.dart';

void main() {
  testWidgets('Add a new task and delete it', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => NewTaskProvider(),
        child: const MaterialApp(home: NewHomeScreen()),
      ),
    );

    // Verify there are no tasks initially
  expect(find.text('New Task'), findsNothing);

  // Simulate tapping on the FloatingActionButton to add a task
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pump();

  // Simulate adding a task
  await tester.enterText(find.byType(TextField), 'New Task');
  await tester.tap(find.text('Add'));
  await tester.pump(); // Rebuilds the UI

  // Verify the task is now present in the list
  expect(find.text('New Task'), findsOneWidget);

  // Ensure the delete icon is present before attempting to tap it
  expect(find.byIcon(Icons.delete), findsOneWidget);

  // Delete the task
  await tester.tap(find.byIcon(Icons.delete));
  await tester.pump(); // Rebuilds the UI

  // Verify the task is deleted
  expect(find.text('New Task'), findsNothing);
  });

}
