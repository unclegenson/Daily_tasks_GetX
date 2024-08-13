import 'dart:io';
import 'package:daily_tasks_getx/controllers/image_controller.dart';
import 'package:daily_tasks_getx/controllers/user_info_controller.dart';
import 'package:daily_tasks_getx/models/hive_models.dart';
import 'package:daily_tasks_getx/screens/home.dart';
import 'package:daily_tasks_getx/screens/settings_screen.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

Future showOptions() async {
  Get.defaultDialog(
    backgroundColor: Colors.transparent,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.indigo[400],
          ),
          child: Text(
            'Gallery'.tr,
            style: const TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Get.find<ImageController>().getImage(ImageSource.gallery);

            Get.find<UserInfoController>().image.value =
                Get.find<ImageController>().imagePath.value;
          },
        ),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.indigo[400],
          ),
          child: Text(
            'Camera'.tr,
            style: const TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Get.find<ImageController>().getImage(ImageSource.camera);
          },
        ),
      ],
    ),
  );
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBarWidget(
        action: false,
        back: true,
        titleText: "Edit Profile".tr,
        svgIcon: 'assets/back2.svg',
        fontSize: 46,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Obx(
                      () {
                        if (Get.find<ImageController>().imagePath.value == '') {
                          return CircleAvatar(
                            backgroundColor: Colors.indigo[400],
                            radius: Get.width / 2 - 30,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: Get.width / 2,
                            ),
                          );
                        } else {
                          return CircleAvatar(
                            backgroundColor: Colors.indigo[400],
                            backgroundImage: FileImage(
                              File(
                                Get.find<ImageController>().imagePath.value,
                              ),
                            ),
                            radius: Get.width / 2 - 30,
                          );
                        }
                      },
                    ),
                    const GalleryOrCameraImage()
                  ],
                ),
              ),
              SettingsCategoryWidget(
                text: 'Name :'.tr,
                color: Colors.white,
              ),
              const NameTextFiled(),
              SettingsCategoryWidget(
                color: Colors.white,
                text: 'Number :'.tr,
              ),
              const NumberTextField(),
              SizedBox(
                height: Get.height / 10,
              ),
              const DoneButton()
            ],
          ),
        ),
      ),
    );
  }
}

class GalleryOrCameraImage extends StatelessWidget {
  const GalleryOrCameraImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showOptions,
      child: Padding(
        padding: EdgeInsets.all(Get.width / 20),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black54,
          ),
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.edit,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class DoneButton extends StatelessWidget {
  const DoneButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width - 40,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo[400],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () async {
          if (Get.find<UserInfoController>().name.value == '' ||
              Get.find<UserInfoController>().number.value == '') {
            Get.snackbar(
              'error!',
              'You must add your profile data to use the app Your profile data will be unreachable for others.'
                  .tr,
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(15),
              colorText: Colors.white,
              duration: const Duration(seconds: 4),
            );
          } else {
            Hive.box<UserInfo>('user').values.forEach(
              (element) {
                Hive.box<UserInfo>('user').putAt(
                  0,
                  UserInfo(
                    name: Get.find<UserInfoController>().name.value,
                    number: Get.find<UserInfoController>().number.value,
                    dailyReminderHour: element.dailyReminderHour,
                    image: Get.find<ImageController>().imagePath.value,
                    language: element.language,
                    selectedColorAlpha: element.selectedColorAlpha,
                    selectedColorBlue: element.selectedColorBlue,
                    selectedColorGreen: element.selectedColorGreen,
                    selectedColorRed: element.selectedColorRed,
                  ),
                );
              },
            );
            Get.offAll(
              () => const Home(),
            );
          }
        },
        child: Text(
          'Done'.tr,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class NumberTextField extends StatelessWidget {
  const NumberTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        inputFormatters: [LengthLimitingTextInputFormatter(11)],
        decoration: const InputDecoration(
          hintText: '09100000000',
          hintStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        onChanged: (value) {
          if (value.length > 10) {
            String val1 = value.substring(1, 4);
            String val2 = value.substring(4, 7);
            String val3 = value.substring(7);

            Get.find<UserInfoController>().number.value =
                '+98 $val1 $val2 $val3';
          }
        },
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class NameTextFiled extends StatelessWidget {
  const NameTextFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        onChanged: (value) {
          Get.find<UserInfoController>().name.value = value;
        },
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
