import 'package:daily_tasks_getx/models/hive_models.dart';
import 'package:daily_tasks_getx/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TasksAdapter());
  await Hive.openBox<Tasks>('Tasks');

  Hive.registerAdapter(TasksAdapter());
  await Hive.openBox<Categories>('Categories');

  Hive.registerAdapter(TasksAdapter());
  await Hive.openBox<Birthdays>('Birthdays');

  Hive.registerAdapter(TasksAdapter());
  await Hive.openBox<UserInfo>('UserInfo');

  runApp(const DailyTasksApp());
}

class DailyTasksApp extends StatelessWidget {
  const DailyTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Daily Tasks',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
