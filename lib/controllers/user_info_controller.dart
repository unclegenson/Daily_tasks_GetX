import 'package:daily_tasks_getx/models/hive_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class UserInfoController extends GetxController {
  var name = ''.obs;
  var number = ''.obs;
  var dailyReminderHour = 0.obs;
  var image = ''.obs;
  var language = ''.obs;
  var selectedColorAlpha = 0.obs;
  var selectedColorBlue = 0.obs;
  var selectedColorGreen = 0.obs;
  var selectedColorRed = 0.obs;

  Color? buttonColor;
  @override
  void onInit() {
    Hive.box<UserInfo>('user').values.forEach((element) {
      name.value = element.name!;
      number.value = element.number!;
      dailyReminderHour.value = element.dailyReminderHour!;
      image.value = element.image!;
      language.value = element.language!;
      selectedColorAlpha.value = element.selectedColorAlpha!;
      selectedColorBlue.value = element.selectedColorBlue!;
      selectedColorGreen.value = element.selectedColorGreen!;
      selectedColorRed.value = element.selectedColorRed!;
    });
    buttonColor = Color.fromARGB(
      selectedColorAlpha.value,
      selectedColorRed.value,
      selectedColorGreen.value,
      selectedColorBlue.value,
    );
    super.onInit();
  }

  void userHiveFirstTime() async {
    var user = UserInfo(
      name: name.value,
      number: number.value,
      dailyReminderHour: dailyReminderHour.value,
      image: image.value,
      language: language.value,
      selectedColorAlpha: selectedColorAlpha.value,
      selectedColorBlue: selectedColorBlue.value,
      selectedColorGreen: selectedColorGreen.value,
      selectedColorRed: selectedColorRed.value,
    );
    await Hive.box<UserInfo>('user').add(user);
    buttonColor = Color.fromARGB(
      selectedColorAlpha.value,
      selectedColorRed.value,
      selectedColorGreen.value,
      selectedColorBlue.value,
    );
  }

  void updateUserHiveInfo() {
    var user = UserInfo(
      name: name.value,
      number: number.value,
      dailyReminderHour: dailyReminderHour.value,
      image: image.value,
      language: language.value,
      selectedColorAlpha: selectedColorAlpha.value,
      selectedColorBlue: selectedColorBlue.value,
      selectedColorGreen: selectedColorGreen.value,
      selectedColorRed: selectedColorRed.value,
    );
    Hive.box<UserInfo>('user').putAt(0, user);
    buttonColor = Color.fromARGB(
      selectedColorAlpha.value,
      selectedColorRed.value,
      selectedColorGreen.value,
      selectedColorBlue.value,
    );
  }
}
