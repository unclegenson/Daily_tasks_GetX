import 'package:daily_tasks_getx/controllers/trasnlate_cntroller.dart';
import 'package:daily_tasks_getx/controllers/user_info_controller.dart';
import 'package:daily_tasks_getx/models/hive_models.dart';
import 'package:daily_tasks_getx/screens/settings_screen.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

int selectedLang = 0;

class MoreSettingsScreen extends StatelessWidget {
  const MoreSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (Hive.box<UserInfo>('user').values.first.language == 'en') {
      selectedLang = 0;
    } else {
      selectedLang = 1;
    }
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBarWidget(
        action: false,
        back: true,
        titleText: "More Settings".tr,
        svgIcon: 'assets/back2.svg',
        fontSize: 46,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8, left: 16, right: 8),
            child: SettingsCategoryWidget(
              color: Colors.white,
              text: 'Set Language'.tr,
            ),
          ),
          const LanguageWidget(),
          Column(
            children: [
              const Divider(indent: 12, endIndent: 12),
              Padding(
                padding: EdgeInsets.only(top: 8, left: 16, right: 8),
                child: SettingsCategoryWidget(
                  color: Colors.white,
                  text: 'App Theme'.tr,
                ),
              ),
            ],
          ),
          const ColorWidget(),
        ],
      ),
    );
  }
}

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Get.height / 16,
          width: Get.width / 2 - 40,
          child: GestureDetector(
            onTap: () {
              Get.find<TrasnlateController>().changeLanguage('en');
              selectedLang = 0;
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedLang == 0 ? Colors.teal : Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'English'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: Get.height / 16,
          width: Get.width / 2 - 40,
          child: GestureDetector(
            onTap: () {
              Get.find<TrasnlateController>().changeLanguage('fa');
              selectedLang = 1;
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedLang == 1 ? Colors.teal : Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Persian".tr,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ColorWidget extends StatelessWidget {
  const ColorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 10,
      width: Get.width - 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _openColorPicker,
            child: Container(
              height: 50,
              width: Get.width / 3,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Choose'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

void _openDialog(String title, Widget content) {
  Get.defaultDialog(
    title: title,
    content: content,
    cancel: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text(
        'cancel'.tr,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    confirm: TextButton(
      onPressed: () {
        Get.back();
        Get.back();
        Get.back();
        Get.back();

        Get.snackbar(
          'SuccessFul'.tr,
          'App Theme SuccessFully Updated'.tr,
          icon: const Icon(
            Icons.check,
            color: Colors.green,
          ),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(15),
        );
      },
      child: Text(
        'submit'.tr,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
}

void _openColorPicker() async {
  _openDialog(
    '',
    MaterialColorPicker(
      onColorChange: (color) async {
        var userInfo = Get.find<UserInfoController>();
        //
        userInfo.selectedColorAlpha.value = color.alpha;
        userInfo.selectedColorBlue.value = color.blue;
        userInfo.selectedColorGreen.value = color.green;
        userInfo.selectedColorRed.value = color.red;

        if (Hive.box<UserInfo>('user').isEmpty) {
          //! maybe some bug here
          userInfo.userHiveFirstTime();
        } else {
          userInfo.selectedColorAlpha.value = color.alpha;
          userInfo.selectedColorBlue.value = color.blue;
          userInfo.selectedColorGreen.value = color.green;
          userInfo.selectedColorRed.value = color.red;
          userInfo.updateUserHiveInfo();
        }
      },
    ),
  );
}
