import 'package:bottom_picker/bottom_picker.dart';
import 'package:daily_tasks_getx/screens/settings_screen.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

int reminderHour = 23;
int reminderMin = 0;

void openDateTimePicker(BuildContext context) {
  BottomPicker.time(
    initialTime: Time.now(),
    pickerTitle: Text(
      'reminder Time',
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        color: Colors.blue,
      ),
    ),
    gradientColors: const [Colors.white, Colors.blue],
    backgroundColor: Colors.black87,
    closeIconColor: Colors.white,
    pickerTextStyle: const TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    onSubmit: (p0) {
      // setState(() {
      //   reminderHour = p0.hour;
      //   reminderMin = p0.minute;
      // });
    },
  ).show(context);
}
// @override
// void initState() {
//   getReminderTime();
//   super.initState();
// }

Future<void> getReminderTime() async {
  SharedPreferences prefDailyReminderHour =
      await SharedPreferences.getInstance();
  SharedPreferences prefDailyReminderMin =
      await SharedPreferences.getInstance();

  // setState(() {
  //   reminderMin = prefDailyReminderMin.getInt('reminderMin')!;
  //   reminderHour = prefDailyReminderHour.getInt('reminderHour')!;
  // });
}

Future<void> setReminderTime() async {
  SharedPreferences prefDailyReminderHour =
      await SharedPreferences.getInstance();
  SharedPreferences prefDailyReminderMin =
      await SharedPreferences.getInstance();

  prefDailyReminderMin.setInt('reminderMin', reminderMin);
  prefDailyReminderHour.setInt('reminderHour', reminderHour);
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: const AppBarWidget(
        action: false,
        back: true,
        titleText: "Notification Settings",
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
                const Padding(
                  padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: SettingsCategoryWidget(
                    color: Colors.white,
                    text: 'Choose best daily reminder time',
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
                      'choose',
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 5 / 10,
                ),
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
                        text: 'your best daily reminder',
                      ),
                      const Spacer(),
                      Text(
                        '${reminderHour.toString().length > 1 ? '$reminderHour' : '0$reminderHour'} : ${reminderMin.toString().length > 1 ? '$reminderMin' : '0$reminderMin'}',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
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
                    onPressed: () {
                      setReminderTime();
                      Get.back();
                      Get.snackbar('Good!',
                          'Daily reminder set at ${reminderHour.toString().length > 1 ? '$reminderHour' : '0$reminderHour'} : ${reminderMin.toString().length > 1 ? '$reminderMin' : '0$reminderMin'}');
                    },
                    child: Text(
                      'save',
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
