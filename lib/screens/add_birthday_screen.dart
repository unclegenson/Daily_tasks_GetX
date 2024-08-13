// ignore_for_file: use_build_context_synchronously

// import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:daily_tasks_getx/controllers/birthday_controller.dart';
import 'package:daily_tasks_getx/controllers/user_info_controller.dart';
import 'package:daily_tasks_getx/models/general_models.dart';
import 'package:daily_tasks_getx/screens/settings_screen.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

void openDateTimePicker2(BuildContext context) {
  BottomPicker.date(
    pickerTitle: Text(
      'Add Birthday Date'.tr,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Get.find<UserInfoController>().buttonColor,
      ),
    ),
    gradientColors: [Get.find<UserInfoController>().buttonColor!, Colors.blue],
    backgroundColor: Colors.black87,
    closeIconColor: Get.find<UserInfoController>().buttonColor!,
    initialDateTime: DateTime(DateTime.now().year),
    maxDateTime: DateTime(DateTime.now().year),
    minDateTime: DateTime(1900),
    pickerTextStyle: const TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    onChange: (p0) {
      time = p0;
      Get.find<BirthdayController>().day.value = time.day;
      Get.find<BirthdayController>().mounth.value = time.month;
      Get.find<BirthdayController>().year.value = time.year;
    },
  ).show(context);
}

class AddBirthdayScreen extends StatelessWidget {
  const AddBirthdayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBarWidget(
        action: false,
        back: true,
        titleText: "Set Birthdays".tr,
        svgIcon: 'assets/back2.svg',
        fontSize: 46,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: Get.height * 9 / 10,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShowBirthdays(),
                SizedBox(
                  height: 4,
                ),
                Divider(
                  thickness: 3,
                ),
                Inputs(),
                Spacer(),
                SaveButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Inputs extends StatelessWidget {
  const Inputs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: SettingsCategoryWidget(
            color: Colors.white,
            text: !Get.find<BirthdayController>().wantToChange.value
                ? 'Add Name'.tr
                : 'Edit Name'.tr,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
          child: TextFormField(
            controller: Get.find<BirthdayController>().nameCon,
            onChanged: (value) {
              Get.find<BirthdayController>().name.value = value;
            },
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: SettingsCategoryWidget(
            color: Colors.white,
            text: !Get.find<BirthdayController>().wantToChange.value
                ? 'Add Birthday Date'.tr
                : 'Edit Birthday Date'.tr,
          ),
        ),
        Container(
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
                Obx(() {
                  return Text(
                    '${Get.find<BirthdayController>().day.value.toString()}.${Get.find<BirthdayController>().mounth.value.toString()}.${Get.find<BirthdayController>().year.toString()}',
                    style: const TextStyle(fontSize: 20, color: Colors.white70),
                  );
                }),
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
            text: !Get.find<BirthdayController>().wantToChange.value
                ? 'Add Phone Number'.tr
                : 'Edit Phone Number'.tr,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
          child: TextFormField(
            keyboardType: TextInputType.phone,
            controller: Get.find<BirthdayController>().numberCon,
            onChanged: (value) {
              Get.find<BirthdayController>().number.value = value;
            },
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(() {
          return SizedBox(
            width: Get.find<BirthdayController>().wantToChange.value == false
                ? Get.width - 40
                : Get.width - 100,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Get.find<UserInfoController>().buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                if (Get.find<BirthdayController>().wantToChange.value) {
                  if (Get.find<BirthdayController>().name.value != '') {
                    Get.find<BirthdayController>().birthdays.add(
                          BirthdayModel(
                            name: Get.find<BirthdayController>().name.value,
                            number: Get.find<BirthdayController>().number.value,
                            day: Get.find<BirthdayController>().day.value,
                            mounth: Get.find<BirthdayController>().mounth.value,
                            year: Get.find<BirthdayController>().year.value,
                          ),
                        );

                    Get.find<BirthdayController>()
                        .birthdays
                        .removeAt(Get.find<BirthdayController>().index);

                    Get.snackbar(
                      'Good!'.tr,
                      'We will let you know at ${'${Get.find<BirthdayController>().mounth.value}/${Get.find<BirthdayController>().day.value}'}!'
                          .tr,
                      margin: const EdgeInsets.all(20),
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                      icon: const Icon(
                        Icons.cake_sharp,
                        color: Colors.white,
                      ),
                    );

                    // await AwesomeNotifications().createNotification(
                    //   schedule: NotificationCalendar(
                    //     day: time.day,
                    //     month: time.month,
                    //     repeats: true,
                    //   ),
                    //   content: NotificationContent(
                    //     category: NotificationCategory.Reminder,
                    //     wakeUpScreen: true,
                    //     color: Get.find<UserInfoController>().buttonColor,
                    //     id: 10,
                    //     channelKey: 'chanel',
                    //     title: 'Daily Tasks'.tr,
                    //     body:
                    //         "${Get.find<BirthdayController>().nameCon}'s birthday is next week on ${time.day}!"
                    //             .tr, // add this to localization
                    //   ),
                    // );

                    Get.back();
                  } else {
                    Get.snackbar(
                      'Ok!'.tr,
                      'Birthday Item edited!'.tr,
                      margin: const EdgeInsets.all(20),
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                    );
                  }
                } else {
                  if (Get.find<BirthdayController>().name.value != '') {
                    Get.find<BirthdayController>().birthdays.add(
                          BirthdayModel(
                            name: Get.find<BirthdayController>().name.value,
                            number: Get.find<BirthdayController>().number.value,
                            day: Get.find<BirthdayController>().day.value,
                            mounth: Get.find<BirthdayController>().mounth.value,
                            year: Get.find<BirthdayController>().year.value,
                          ),
                        );
                    Get.find<BirthdayController>().nameCon.text = '';
                    Get.find<BirthdayController>().numberCon.text = '';
                    Get.find<BirthdayController>().day.value = 0;
                    Get.find<BirthdayController>().mounth.value = 0;
                    Get.find<BirthdayController>().year.value = 0;

                    // await AwesomeNotifications().createNotification(
                    //   schedule: NotificationCalendar(
                    //     day: time.day,
                    //     month: time.month,
                    //     repeats: true,
                    //   ),
                    //   content: NotificationContent(
                    //     category: NotificationCategory.Reminder,
                    //     wakeUpScreen: true,
                    //     color: Get.find<UserInfoController>().buttonColor,
                    //     id: 10,
                    //     channelKey: 'chanel',
                    //     title: 'Daily Tasks'.tr,
                    //     body:
                    //         "${Get.find<BirthdayController>().nameCon}'s birthday is next week on ${time.day}!"
                    //             .tr, // add this to localization
                    //   ),
                    // );
                    Get.snackbar(
                      'Good!'.tr,
                      'We will let you know at $time!'.tr,
                      margin: const EdgeInsets.all(20),
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                    );

                    Get.back();
                  } else {
                    Get.snackbar(
                      'error!'.tr,
                      'Nothing Added'.tr,
                      margin: const EdgeInsets.all(20),
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                    );
                  }
                }
              },
              child: Text(
                'Save'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          );
        }),
        Obx(
          () {
            if (Get.find<BirthdayController>().wantToChange.value == true) {
              return SizedBox(
                width: 70,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    PanaraConfirmDialog.showAnimatedGrow(
                      context,
                      title: 'Delete This Birhtday item'.tr,
                      message:
                          'Are you sure you want to delete this Birhday?'.tr,
                      confirmButtonText: 'Yes'.tr,
                      cancelButtonText: 'No'.tr,
                      onTapCancel: () {
                        Navigator.pop(context);
                      },
                      onTapConfirm: () {
                        Get.find<BirthdayController>()
                            .birthdays
                            .removeAt(Get.find<BirthdayController>().index);
                        Get.find<BirthdayController>().nameCon.text = '';
                        Get.find<BirthdayController>().numberCon.text = '';
                        Get.find<BirthdayController>().wantToChange.value =
                            false;

                        Get.back();
                      },
                      panaraDialogType: PanaraDialogType.warning,
                      noImage: true,
                    );
                  },
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }
}

class ShowBirthdays extends StatelessWidget {
  const ShowBirthdays({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 4.5 / 10,
      child: Obx(
        () {
          return ListView.builder(
            itemCount: Get.find<BirthdayController>().birthdays.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: const EdgeInsets.only(left: 8),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Get.find<BirthdayController>().wantToChange.value = true;
                    Get.find<BirthdayController>().index = index;

                    Get.find<BirthdayController>().name.value =
                        Get.find<BirthdayController>().birthdays[index].name!;
                    Get.find<BirthdayController>().nameCon.text =
                        Get.find<BirthdayController>().birthdays[index].name!;

                    Get.find<BirthdayController>().number.value =
                        Get.find<BirthdayController>().birthdays[index].number!;
                    Get.find<BirthdayController>().numberCon.text =
                        Get.find<BirthdayController>().birthdays[index].number!;

                    Get.find<BirthdayController>().day.value =
                        Get.find<BirthdayController>().birthdays[index].day!;

                    Get.find<BirthdayController>().mounth.value =
                        Get.find<BirthdayController>().birthdays[index].mounth!;

                    Get.find<BirthdayController>().year.value =
                        Get.find<BirthdayController>().birthdays[index].year!;
                  },
                ),
                title: Text(
                  Get.find<BirthdayController>().birthdays[index].name!,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w300),
                ),
                subtitle: Text(
                  '${Get.find<BirthdayController>().birthdays[index].day}.${Get.find<BirthdayController>().birthdays[index].mounth}.${Get.find<BirthdayController>().birthdays[index].year}',
                  style: TextStyle(color: Colors.white70),
                ),
                leading: const Icon(Icons.circle),
              );
            },
          );
        },
      ),
    );
  }
}
