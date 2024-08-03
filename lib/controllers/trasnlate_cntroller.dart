import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrasnlateController extends GetxController {
  void changeLanguage(String language) {
    var locale = Locale(language);
    Get.updateLocale(locale);
  }
}
