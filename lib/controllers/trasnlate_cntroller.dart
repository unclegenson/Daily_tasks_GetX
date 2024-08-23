import 'package:daily_tasks_getx/controllers/user_info_controller.dart';
import 'package:daily_tasks_getx/models/hive_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class TrasnlateController extends GetxController {
  void changeLanguage(String language) {
    var locale = Locale(language);
    Get.updateLocale(locale);
    Hive.box<UserInfo>('user').values.forEach(
      (element) {
        Hive.box<UserInfo>('user').putAt(
          0,
          UserInfo(
            name: element.name,
            number: element.number,
            dailyReminderHour: element.dailyReminderHour,
            dailyReminderMinute: element.dailyReminderMinute,
            image: element.image,
            language: language,
            selectedColorAlpha: element.selectedColorAlpha,
            selectedColorBlue: element.selectedColorBlue,
            selectedColorGreen: element.selectedColorGreen,
            selectedColorRed: element.selectedColorRed,
          ),
        );
        Get.find<UserInfoController>().language.value = language;
      },
    );
  }
}
