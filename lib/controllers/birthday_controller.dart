import 'package:daily_tasks_getx/models/general_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BirthdayController extends GetxController {
  var birthdays = <BirthdayModel>[].obs;
  var name = ''.obs;
  var wantToChange = false.obs;
  var index = 0;
  var nameCon = TextEditingController();
  var number = ''.obs;
  var day = 0.obs;
  var mounth = 0.obs;
  var year = 0.obs;

  var numberCon = TextEditingController();

  @override
  void onInit() {
    var box = GetStorage();

    if (box.read('birhdays') != null) {
      var birhdaysList = box.read('birhdays');
      for (var birthdayItem in birhdaysList) {
        birthdays.add(BirthdayModel.fromJson(birthdayItem));
      }
    }

    ever(birthdays, (callback) {
      box.write('birhdays', birthdays.toJson());
    });
    super.onInit();
  }
}
