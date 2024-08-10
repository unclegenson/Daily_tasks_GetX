import 'package:daily_tasks_getx/models/general_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CategoryController extends GetxController {
  var categories = <CategoriesModel>[].obs;
  var category = ''.obs;
  var wantToChange = false.obs;
  var index = 0;
  var con = TextEditingController();

  @override
  void onInit() {
    var box = GetStorage();

    if (box.read('categories') != null) {
      var categoriesList = box.read('categories');
      for (var categoryItem in categoriesList) {
        categories.add(CategoriesModel.fromJson(categoryItem));
      }
    }

    ever(categories, (callback) {
      box.write('categories', categories.toJson());
    });
    super.onInit();
  }
}
