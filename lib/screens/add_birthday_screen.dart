// ignore_for_file: use_build_context_synchronously

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:daily_tasks_getx/controllers/user_info_controller.dart';
import 'package:daily_tasks_getx/screens/settings_screen.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color? selectedColor2;

List birthDayList = [];
List nameList = [];
List numberList = [];
bool showTime = false;
DateTime time = DateTime.now();

bool wantToChange = false;
TextEditingController nameCon = TextEditingController();
DateTime newBirthdayDate = DateTime.now();
String? newName;
String? newPhone;
int indexx = 0;
TextEditingController numberCon = TextEditingController();
// @override
// void initState() {
//   // selectedColor2 = colorItems[Random().nextInt(colorItems.length)];
//   wantToChange = false;
//   nameCon.clear();
//   numberCon.clear();

//   newName = '';
//   newPhone = '';

//   birthDayList.clear();
//   nameList.clear();
//   // Hive.box<Birthdays>('birthdayBox').values.forEach((element) {
//   //   nameList.add(element.name);
//   //   numberList.add(element.number);
//   //   birthDayList.add(element.date);
//   // });

//   super.initState();
// }

void openDateTimePicker2(BuildContext context) {
  BottomPicker.date(
    pickerTitle: Text(
      'add Birthday Date',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Get.find<UserInfoController>().buttonColor,
      ),
    ),
    gradientColors: [selectedColor2!, Colors.blue],
    backgroundColor: Colors.black87,
    closeIconColor: selectedColor2!,
    initialDateTime: DateTime(DateTime.now().year),
    maxDateTime: DateTime(DateTime.now().year),
    minDateTime: DateTime(1900),
    pickerTextStyle: const TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    onChange: (p0) {
      // setState(() {
      //   time = p0;
      //   newBirthdayDate = time;
      // });
    },
  ).show(context);
}

class AddBirthdayScreen extends StatelessWidget {
  const AddBirthdayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: const AppBarWidget(
        action: false,
        back: true,
        titleText: "Set Birtdays",
        svgIcon: 'assets/back2.svg',
        fontSize: 46,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: Get.height * 9 / 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 5 / 10,
                  child: ListView.builder(
                    itemCount: nameList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.only(left: 8),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // setState(() {
                            //   wantToChange = true;
                            //   indexx = index;

                            //   newName = nameList[index];
                            //   nameCon.text = newName!;

                            //   newPhone = numberList[index];
                            //   numberCon.text = newPhone!;

                            //   newBirthdayDate = birthDayList[index];
                            //   time = newBirthdayDate;
                            // });
                          },
                        ),
                        title: Text(
                          nameList[index],
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                        ),
                        subtitle: Text(
                            birthDayList[index].toString().substring(0, 10)),
                        leading: const Icon(Icons.circle),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Divider(
                  thickness: 3,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: SettingsCategoryWidget(
                    color: Colors.white,
                    text: !wantToChange ? 'addName' : 'editName',
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
                  child: TextFormField(
                    controller: nameCon,
                    onChanged: (value) {
                      // setState(() {
                      //   newName = value;
                      // });
                    },
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: SettingsCategoryWidget(
                    color: Colors.white,
                    text: !wantToChange
                        ? 'add Birthday Date'
                        : 'edit Birthday Date',
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: Get.width - 56,
                  height: 55,
                  child: InkWell(
                    onTap: () {
                      return openDateTimePicker2(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${time.day.toString()}.${time.month.toString()}.${time.year.toString()}',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white70),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(
                          height: 0,
                          color: Colors.white54,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: SettingsCategoryWidget(
                    color: Colors.white,
                    text: !wantToChange
                        ? 'add Phone Number'
                        : 'edit Phone Number',
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
                  child: TextFormField(
                    controller: numberCon,
                    onChanged: (value) {
                      // setState(() {
                      //   newPhone = value;
                      // });
                    },
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: Get.width - 40,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Get.find<UserInfoController>().buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (wantToChange) {
                        if (newName != '') {
                          // setState(() {
                          //   nameList.add(newName);
                          //   numberList.add(newPhone);
                          //   birthDayList.add(newBirthdayDate);
                          //   nameList.removeAt(indexx);
                          //   numberList.removeAt(indexx);
                          //   birthDayList.removeAt(indexx);
                          // });
                          // Hive.box<Birthdays>('birthdayBox').putAt(
                          //   indexx,
                          //   Birthdays(
                          //     name: newName,
                          //     number: newPhone,
                          //     date: newBirthdayDate,
                          //   ),
                          // );
                          Get.snackbar(
                            'Good!',
                            'We will let you know at $time!',
                            margin: EdgeInsets.all(20),
                            snackPosition: SnackPosition.BOTTOM,
                          );

                          await AwesomeNotifications().createNotification(
                            schedule: NotificationCalendar(
                              day: time.day,
                              month: time.month,
                              repeats: true,
                            ),
                            content: NotificationContent(
                              category: NotificationCategory.Reminder,
                              wakeUpScreen: true,
                              color: Get.find<UserInfoController>().buttonColor,
                              id: 10,
                              channelKey: 'chanel',
                              title: 'Daily Tasks',
                              body:
                                  "$nameCon's birthday is next week on ${time.day}!", // add this to localization
                            ),
                          );

                          Navigator.pop(context);
                        } else {
                          Get.snackbar(
                            'Ok!',
                            'Birthday Item edited!',
                            margin: EdgeInsets.all(20),
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      } else {
                        if (newName != '') {
                          // setState(() {
                          //   nameList.add(newName);
                          //   numberList.add(newPhone);
                          //   birthDayList.add(newBirthdayDate);
                          // });
                          // Hive.box<Birthdays>('birthdayBox').add(
                          //   Birthdays(
                          //     name: newName,
                          //     number: newPhone,
                          //     date: newBirthdayDate,
                          //   ),
                          // );

                          await AwesomeNotifications().createNotification(
                            schedule: NotificationCalendar(
                              day: time.day,
                              month: time.month,
                              repeats: true,
                            ),
                            content: NotificationContent(
                              category: NotificationCategory.Reminder,
                              wakeUpScreen: true,
                              color: Get.find<UserInfoController>().buttonColor,
                              id: 10,
                              channelKey: 'chanel',
                              title: 'Daily Tasks',
                              body:
                                  "$nameCon's birthday is next week on ${time.day}!", // add this to localization
                            ),
                          );
                          Get.snackbar(
                            'Good!',
                            'We will let you know at $time!',
                            margin: EdgeInsets.all(20),
                            snackPosition: SnackPosition.BOTTOM,
                          );

                          Get.back();
                        } else {
                          Get.snackbar(
                            'error!',
                            'nothingAdded',
                            margin: EdgeInsets.all(20),
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      }
                    },
                    child: Text(
                      'save',
                      style: const TextStyle(color: Colors.black, fontSize: 20),
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
