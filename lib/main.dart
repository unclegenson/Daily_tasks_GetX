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
    var user = Hive.box<UserInfo>('user').values.first;
    bool isFirstTime = false;
    if (user.name != '') {
      isFirstTime = false;
    } else {
      isFirstTime = true;
    }
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

//todo: edit all snackbar translate
//todo: change the location of all . : ! to end of translate sentances 
//todo: notifications
//todo: review screen
//todo: purchse check
//todo: logo and app name
//todo: publish

