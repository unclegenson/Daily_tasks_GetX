import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:daily_tasks_getx/controllers/notif_controller.dart';
import 'package:daily_tasks_getx/screens/settings_screen.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void openDateTimePicker(BuildContext context) {
  BottomPicker.time(
    initialTime: Time.now(),
    pickerTitle: Text(
      'Reminder Time'.tr,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: Colors.orangeAccent,
      ),
    ),
    gradientColors: const [Colors.orangeAccent, Colors.blue],
    backgroundColor: Colors.black87,
    closeIconColor: Colors.orangeAccent,
    pickerTextStyle: const TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    onSubmit: (p0) {
      Get.find<NotifController>().hour.value = p0.hour;
      Get.find<NotifController>().minute.value = p0.minute;
    },
  ).show(context);
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBarWidget(
        action: false,
        back: true,
        titleText: "Notification Settings".tr,
        svgIcon: 'assets/back2.svg',
        fontSize: 46,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: Get.height * 8 / 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: SettingsCategoryWidget(
                    color: Colors.white,
                    text: 'Choose best daily reminder time'.tr,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: Get.width / 3,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      return openDateTimePicker(context);
                    },
                    child: Text(
                      'Choose'.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                const Spacer(),
                const SizedBox(
                  height: 4,
                ),
                const Divider(
                  thickness: 3,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: Row(
                    children: [
                      SettingsCategoryWidget(
                        color: Colors.white,
                        text: 'Your best daily reminder :'.tr,
                      ),
                      const Spacer(),
                      Obx(
                        () => Text(
                          '${Get.find<NotifController>().hour.value.toString().length > 1 ? '${Get.find<NotifController>().hour.value}' : '0${Get.find<NotifController>().hour.value}'} : ${Get.find<NotifController>().minute.value.toString().length > 1 ? '${Get.find<NotifController>().minute.value}' : '0${Get.find<NotifController>().minute.value}'}',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  width: Get.width - 40,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      Get.back();
                      int reminderHour = Get.find<NotifController>().hour.value;
                      int reminderMin =
                          Get.find<NotifController>().minute.value;
                      Get.snackbar(
                        'Good!'.tr,
                        '${'Daily reminder set at'.tr} ${reminderHour.toString().length > 1 ? '$reminderHour' : '0$reminderHour'} : ${reminderMin.toString().length > 1 ? '$reminderMin' : '0$reminderMin'}',
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white,
                        margin: const EdgeInsets.all(20),
                      );
                      AwesomeNotifications().createNotification(
                        content: NotificationContent(
                          id: 13,
                          wakeUpScreen: true,
                          category: NotificationCategory.Reminder,
                          channelKey: 'chanel',
                          title: 'Daily Tasks reminder'.tr,
                          body: "Make your tomorrow's plan ready!",
                        ),
                        schedule: NotificationCalendar(
                          hour: reminderHour,
                          minute: reminderMin,
                          repeats: true,
                        ),
                      );
                    },
                    child: Text(
                      'Save'.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
