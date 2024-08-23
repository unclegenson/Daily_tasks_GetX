import 'package:daily_tasks_getx/models/general_models.dart';
import 'package:daily_tasks_getx/models/hive_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

class NotifController extends GetxController {
  var notifs = <NotifModel>[].obs;
  var wantToChange = false.obs;
  var index = 0;
  var nameCon = TextEditingController();
  var numberCon = TextEditingController();
  var hour = 23.obs;
  var minute = 0.obs;

  @override
  void onInit() {
    Hive.box<UserInfo>('user').values.forEach((element) {
      hour.value = element.dailyReminderHour!;
      minute.value = element.dailyReminderMinute!;
    });
    var box = GetStorage();

    if (box.read('notif') != null) {
      var notifList = box.read('notif');
      for (var notifItem in notifList) {
        notifs.add(NotifModel.fromJson(notifItem));
      }
    }

    ever(notifs, (callback) {
      box.write('notif', notifs.toJson());
    });
    super.onInit();
  }
}
