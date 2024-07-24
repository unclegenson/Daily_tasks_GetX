import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:daily_tasks_getx/bindings/bindings.dart';
import 'package:daily_tasks_getx/models/hive_models.dart';
import 'package:daily_tasks_getx/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await AwesomeNotifications().initialize(
    debug: true,
    null,
    [
      NotificationChannel(
        channelKey: 'chanel',
        channelName: 'notif name',
        channelDescription: 'daily tasks notif',
        channelGroupKey: 'basic_chanel_group',
      )
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_chanel_group',
        channelGroupName: 'basic group',
      )
    ],
  );

  bool isAllowToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (isAllowToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  await Hive.initFlutter();

  Hive.registerAdapter(TasksAdapter());
  await Hive.openBox<Tasks>('Tasks');

  Hive.registerAdapter(CategoriesAdapter());
  await Hive.openBox<Categories>('Categories');

  Hive.registerAdapter(BirthdaysAdapter());
  await Hive.openBox<Birthdays>('Birthdays');

  Hive.registerAdapter(UserInfoAdapter());
  await Hive.openBox<UserInfo>('UserInfo');

  runApp(const DailyTasksApp());
}

class DailyTasksApp extends StatelessWidget {
  const DailyTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MyBindings(),
      title: 'Daily Tasks',
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
