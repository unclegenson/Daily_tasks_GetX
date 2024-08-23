import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:daily_tasks_getx/bindings/bindings.dart';
import 'package:daily_tasks_getx/models/hive_models.dart';
import 'package:daily_tasks_getx/models/translate.dart';
import 'package:daily_tasks_getx/screens/edit_profile.dart';
import 'package:daily_tasks_getx/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  GetStorage();

  await AwesomeNotifications().initialize(
    debug: true,
    null,
    [
      NotificationChannel(
        enableVibration: true,
        playSound: true,
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

  AwesomeNotifications().isNotificationAllowed().then(
    (isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    },
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserInfoAdapter());
  await Hive.openBox<UserInfo>('user');

  runApp(const DailyTasksApp());
}

bool isFirstTime = false;

class DailyTasksApp extends StatelessWidget {
  const DailyTasksApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (Hive.box<UserInfo>('user').isEmpty) {
      isFirstTime = true;
      firstEnter();
    }

    var user = Hive.box<UserInfo>('user').values.first;
    return GetMaterialApp(
      locale: Locale(user.language!),
      translations: Translate(),
      initialBinding: MyBindings(),
      title: 'Daily Tasks',
      debugShowCheckedModeBanner: false,
      home: isFirstTime ? const EditProfileScreen() : const Home(),
    );
  }
}

//todo: notif icon
//todo: notif translate
//todo: publish

void firstEnter() async {
  await Hive.box<UserInfo>('user').add(
    UserInfo(
      name: '',
      number: '',
      dailyReminderHour: 23,
      dailyReminderMinute: 0,
      image: '',
      language: 'en',
      selectedColorAlpha: 255,
      selectedColorBlue: 192,
      selectedColorGreen: 107,
      selectedColorRed: 92,
    ),
  );
}
