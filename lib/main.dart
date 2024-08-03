import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:daily_tasks_getx/bindings/bindings.dart';
import 'package:daily_tasks_getx/models/hive_models.dart';
import 'package:daily_tasks_getx/models/translate.dart';
import 'package:daily_tasks_getx/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  var box = GetStorage();
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

  //hive
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserInfoAdapter());
  await Hive.openBox<UserInfo>('user');
  //

  runApp(const DailyTasksApp());
}

class DailyTasksApp extends StatelessWidget {
  const DailyTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Translate(),
      initialBinding: MyBindings(),
      title: 'Daily Tasks',
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

//todo: open user screen for the first time app opens