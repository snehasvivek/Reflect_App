import 'package:flutter/material.dart';
import 'package:reflect_application/pages/home.dart';
// import 'pages/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  runApp(const MyApp());
  await Hive.initFlutter();

  await Hive.openBox("Habit_Database");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'R E F L E C T',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      home: HomePage(title: 'PROMPT OF THE DAY'),
    );
  }
}
