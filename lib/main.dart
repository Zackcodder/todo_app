import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/authentication_provider.dart';
import 'package:todo_app/providers/new_provider.dart';
import 'package:todo_app/screens/new_home.dart';
// import 'package:todo_app/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewTaskProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),],
      child: MaterialApp(
        title: 'TODO APP',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NewHomeScreen(),
      ),
    );
  }
}
