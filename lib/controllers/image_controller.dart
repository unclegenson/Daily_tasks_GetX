import 'package:daily_tasks_getx/controllers/user_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  var imagePath = ''.obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      Get.find<UserInfoController>().image.value = imagePath.value;
      Get.back();
    } else {
      Get.snackbar(
        'Error'.tr,
        'No Image Selected'.tr,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        margin: const EdgeInsets.all(20),
      );
    }
  }
}
