import 'package:daily_tasks_getx/controllers/task_controller.dart';
import 'package:daily_tasks_getx/controllers/user_info_controller.dart';
import 'package:daily_tasks_getx/screens/edit_profile.dart';
import 'package:daily_tasks_getx/screens/more_settings_screen.dart';
import 'package:daily_tasks_getx/screens/notifications_screen.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBarWidget(
        action: false,
        back: true,
        titleText: "Settings".tr,
        svgIcon: 'assets/back2.svg',
        fontSize: 46,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: Get.height / 2 - 70,
          ),
          itemBuilder: (_, index) {
            if (index == 0) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => const EditProfileScreen());
                },
                child: Container(
                  width: Get.width / 2,
                  decoration: BoxDecoration(
                    color: Colors.indigo[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.fingerprint,
                        size: 45,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Edit Profile'.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (index == 1) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => const NotificationScreen());
                },
                child: Container(
                  width: Get.width / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: Get.width / 2,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.notifications_active_rounded,
                          size: 45,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Notifications'.tr,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            if (index == 2) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => const MoreSettingsScreen());
                },
                child: Container(
                  width: Get.width / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: Get.width / 2,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.folder_open_outlined,
                          size: 45,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'More Settings'.tr,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            if (index == 3) {
              return GestureDetector(
                onTap: () {
                  PanaraConfirmDialog.showAnimatedGrow(
                    context,
                    title: 'Delete All Tasks'.tr,
                    message:
                        "Tap delete if you're sure you wanna delete all tasks"
                            .tr,
                    confirmButtonText: 'delete'.tr,
                    cancelButtonText: 'cancel'.tr,
                    onTapCancel: () {
                      Get.back();
                    },
                    onTapConfirm: () async {
                      Get.find<TaskController>().tasks.clear();
                      Get.back();
                    },
                    panaraDialogType: PanaraDialogType.error,
                    noImage: true,
                  );
                },
                child: Container(
                  width: Get.width / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: Get.width / 2,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.delete,
                          size: 45,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Delete All Tasks'.tr,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return null;
          },
          itemCount: 4,
        ),
      ),
    );
  }
}

class SettingsCategoryWidget extends StatelessWidget {
  const SettingsCategoryWidget({
    super.key,
    required this.text,
    required this.color,
  });

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Get.find<UserInfoController>().language.value == 'en'
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
