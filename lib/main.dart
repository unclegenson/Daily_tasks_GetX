import 'package:daily_tasks_getx/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const DailyTasksApp());
}

class DailyTasksApp extends StatelessWidget {
  const DailyTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Daily TAsks',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
