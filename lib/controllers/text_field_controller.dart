import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TextFieldController extends GetxController {
  TextEditingController? taskTitle;
  TextEditingController? taskDesc;
  String? cat;
  @override
  void onInit() {
    taskTitle = TextEditingController();
    taskDesc = TextEditingController();
    cat = '';
    super.onInit();
  }
}
