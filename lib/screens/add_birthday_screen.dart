import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:daily_tasks_getx/controllers/birthday_controller.dart';
import 'package:daily_tasks_getx/controllers/user_info_controller.dart';
import 'package:daily_tasks_getx/models/general_models.dart';
import 'package:daily_tasks_getx/screens/settings_screen.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';

void showCalender() {
  String lang = Get.find<UserInfoController>().language.value;

  Get.bottomSheet(
    enableDrag: false,
    isDismissible: false,
    backgroundColor: Colors.black87,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        height: Get.height / 2.5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Birthday Date'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Get.find<UserInfoController>().buttonColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Get.find<UserInfoController>().buttonColor,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            LinearDatePicker(
              yearText: lang == 'en' ? 'Year' : 'سال',
              monthText: lang == 'en' ? 'Month' : 'ماه',
              dayText: lang == 'en' ? 'Day' : 'روز',
              labelStyle: TextStyle(
                color: Get.find<UserInfoController>().buttonColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              selectedRowStyle: TextStyle(
                color: Get.find<UserInfoController>().buttonColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              unselectedRowStyle: const TextStyle(
                fontFamily: 'iran',
                fontSize: 16.0,
                color: Colors.grey,
              ),
              startDate: lang == 'en' ? '1900/01/01' : "1300/01/01",
              endDate: lang == 'en' ? '2024/12/29' : "1404/12/29",
              initialDate: lang == 'en' ? '2023/02/02' : "1404/02/02",
              dateChangeListener: (String selectedDate) {
                List parts = selectedDate.split('/');
                Get.find<BirthdayController>().year.value = int.parse(parts[0]);
                Get.find<BirthdayController>().mounth.value =
                    int.parse(parts[1]);
                Get.find<BirthdayController>().day.value = int.parse(parts[2]);
              },
              showMonthName: true,
              columnWidth: 100,
              isJalaali: lang == 'en' ? false : true,
              showLabels: true,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: Get.width - 80,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Get.find<UserInfoController>().buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Select'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SettingsCategoryWidget(
                color: Colors.white,
                text: !Get.find<BirthdayController>().wantToChange.value
                    ? 'Add Name'.tr
                    : 'Edit Name'.tr,
              ),
              IconButton(
                onPressed: () {
                  Get.find<BirthdayController>().nameCon.text = '';
                  Get.find<BirthdayController>().numberCon.text = '';
                  Get.find<BirthdayController>().wantToChange.value = false;
                  Get.find<BirthdayController>().day.value = 0;
                  Get.find<BirthdayController>().mounth.value = 0;
                  Get.find<BirthdayController>().year.value = 0;
                },
                icon: const Icon(
                  Icons.restart_alt_outlined,
                  color: Colors.white,
                ),
              )
            ],
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
              return showCalender();
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
            inputFormatters: [LengthLimitingTextInputFormatter(11)],
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
                  // want to change :
                  if (Get.find<BirthdayController>().name.value != '' &&
                      Get.find<BirthdayController>().number.value != '' &&
                      Get.find<BirthdayController>().day.value != 0) {
                    // check name number and date are not empty
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
                      '${Get.find<BirthdayController>().mounth.value}.${Get.find<BirthdayController>().day.value} ${'We will let you know on'.tr}',
                      margin: const EdgeInsets.all(20),
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                      icon: const Icon(
                        Icons.cake_sharp,
                        color: Colors.white,
                      ),
                    );
                    Get.find<BirthdayController>().nameCon.text = '';
                    Get.find<BirthdayController>().numberCon.text = '';
                    Get.find<BirthdayController>().day.value = 0;
                    Get.find<BirthdayController>().mounth.value = 0;
                    Get.find<BirthdayController>().year.value = 0;
                    if (DateTime(
                          DateTime.now().year,
                          Get.find<BirthdayController>().mounth.value,
                          Get.find<BirthdayController>().day.value,
                        ).compareTo(DateTime.now()) >
                        0) {
                      await AwesomeNotifications().createNotification(
                        schedule: NotificationCalendar(
                          year: DateTime.now().year,
                          day: Get.find<BirthdayController>().day.value,
                          month: Get.find<BirthdayController>().mounth.value,
                          hour: 0,
                          minute: 0,
                        ),
                        content: NotificationContent(
                          category: NotificationCategory.Reminder,
                          wakeUpScreen: true,
                          id: int.parse(Get.find<BirthdayController>()
                              .number
                              .value
                              .substring(3)),
                          channelKey: 'chanel',
                          title: 'Daily Tasks'.tr,
                          body:
                              '${Get.find<BirthdayController>().nameCon.text} ${'s birthday is today!'.tr}',
                        ),
                      );
                      await AwesomeNotifications().createNotification(
                        schedule: NotificationCalendar(
                          year: DateTime.now().year + 1,
                          day: Get.find<BirthdayController>().day.value,
                          month: Get.find<BirthdayController>().mounth.value,
                          hour: 0,
                          minute: 0,
                        ),
                        content: NotificationContent(
                          category: NotificationCategory.Reminder,
                          wakeUpScreen: true,
                          id: int.parse(Get.find<BirthdayController>()
                              .number
                              .value
                              .substring(3)),
                          channelKey: 'chanel',
                          title: 'Daily Tasks'.tr,
                          body:
                              '${Get.find<BirthdayController>().nameCon.text} ${'s birthday is today!'.tr}',
                        ),
                      );
                      await AwesomeNotifications().createNotification(
                        schedule: NotificationCalendar(
                          year: DateTime.now().year + 2,
                          day: Get.find<BirthdayController>().day.value,
                          month: Get.find<BirthdayController>().mounth.value,
                          hour: 0,
                          minute: 0,
                        ),
                        content: NotificationContent(
                          category: NotificationCategory.Reminder,
                          wakeUpScreen: true,
                          id: int.parse(Get.find<BirthdayController>()
                              .number
                              .value
                              .substring(3)),
                          channelKey: 'chanel',
                          title: 'Daily Tasks'.tr,
                          body:
                              '${Get.find<BirthdayController>().nameCon.text} ${'s birthday is today!'.tr}',
                        ),
                      );
                    } else {
                      await AwesomeNotifications().createNotification(
                        schedule: NotificationCalendar(
                          year: DateTime.now().year + 1,
                          day: Get.find<BirthdayController>().day.value,
                          month: Get.find<BirthdayController>().mounth.value,
                          hour: 0,
                          minute: 0,
                        ),
                        content: NotificationContent(
                          category: NotificationCategory.Reminder,
                          wakeUpScreen: true,
                          id: int.parse(Get.find<BirthdayController>()
                              .number
                              .value
                              .substring(3)),
                          channelKey: 'chanel',
                          title: 'Daily Tasks'.tr,
                          body:
                              '${Get.find<BirthdayController>().nameCon.text} ${'s birthday is today!'.tr}',
                        ),
                      );
                      await AwesomeNotifications().createNotification(
                        schedule: NotificationCalendar(
                          year: DateTime.now().year + 2,
                          day: Get.find<BirthdayController>().day.value,
                          month: Get.find<BirthdayController>().mounth.value,
                          hour: 0,
                          minute: 0,
                        ),
                        content: NotificationContent(
                          category: NotificationCategory.Reminder,
                          wakeUpScreen: true,
                          id: int.parse(Get.find<BirthdayController>()
                              .number
                              .value
                              .substring(3)),
                          channelKey: 'chanel',
                          title: 'Daily Tasks'.tr,
                          body:
                              '${Get.find<BirthdayController>().nameCon.text} ${'s birthday is today!'.tr}',
                        ),
                      );
                      await AwesomeNotifications().createNotification(
                        schedule: NotificationCalendar(
                          year: DateTime.now().year + 3,
                          day: Get.find<BirthdayController>().day.value,
                          month: Get.find<BirthdayController>().mounth.value,
                          hour: 0,
                          minute: 0,
                        ),
                        content: NotificationContent(
                          category: NotificationCategory.Reminder,
                          wakeUpScreen: true,
                          id: int.parse(Get.find<BirthdayController>()
                              .number
                              .value
                              .substring(3)),
                          channelKey: 'chanel',
                          title: 'Daily Tasks'.tr,
                          body:
                              '${Get.find<BirthdayController>().nameCon.text} ${'s birthday is today!'.tr}',
                        ),
                      );
                      await AwesomeNotifications().createNotification(
                        schedule: NotificationCalendar(
                          year: DateTime.now().year + 4,
                          day: Get.find<BirthdayController>().day.value,
                          month: Get.find<BirthdayController>().mounth.value,
                          hour: 0,
                          minute: 0,
                        ),
                        content: NotificationContent(
                          category: NotificationCategory.Reminder,
                          wakeUpScreen: true,
                          id: int.parse(Get.find<BirthdayController>()
                              .number
                              .value
                              .substring(3)),
                          channelKey: 'chanel',
                          title: 'Daily Tasks'.tr,
                          body:
                              '${Get.find<BirthdayController>().nameCon.text} ${'s birthday is today!'.tr}',
                        ),
                      );
                    }
                  } else {
                    Get.snackbar(
                      'Error!'.tr,
                      'Check the fields and complete them.'.tr,
                      margin: const EdgeInsets.all(20),
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                    );
                  }
                } else {
                  // want to add:
                  if (Get.find<BirthdayController>().name.value != '' &&
                      Get.find<BirthdayController>().number.value != '' &&
                      Get.find<BirthdayController>().day.value != 0) {
                    Get.find<BirthdayController>().birthdays.add(
                          BirthdayModel(
                            name: Get.find<BirthdayController>().name.value,
                            number: Get.find<BirthdayController>().number.value,
                            day: Get.find<BirthdayController>().day.value,
                            mounth: Get.find<BirthdayController>().mounth.value,
                            year: Get.find<BirthdayController>().year.value,
                          ),
                        );
                    AwesomeNotifications().cancel(
                      int.parse(
                        Get.find<BirthdayController>()
                            .number
                            .value
                            .substring(3),
                      ),
                    );

                    if (DateTime(
                          DateTime.now().year,
                          Get.find<BirthdayController>().mounth.value,
                          Get.find<BirthdayController>().day.value,
                        ).compareTo(DateTime.now()) >
                        0) {
                      await AwesomeNotifications().createNotification(
                        schedule: NotificationCalendar(
                          year: DateTime.now().year,
                          day: Get.find<BirthdayController>().day.value,
                          month: Get.find<BirthdayController>().mounth.value,
                          hour: 0,
                          minute: 0,
                        ),
                        content: NotificationContent(
                          category: NotificationCategory.Reminder,
                          wakeUpScreen: true,
                          id: int.parse(Get.find<BirthdayController>()
                              .number
                              .value
                              .substring(3)),
                          channelKey: 'chanel',
                          title: 'Daily Tasks'.tr,
                          body:
                              '${Get.find<BirthdayController>().nameCon.text} ${'s birthday is today!'.tr}',
                        ),
                      );
                    } else {
                      await AwesomeNotifications().createNotification(
                        schedule: NotificationCalendar(
                          year: DateTime.now().year + 1,
                          day: Get.find<BirthdayController>().day.value,
                          month: Get.find<BirthdayController>().mounth.value,
                          hour: 0,
                          minute: 0,
                        ),
                        content: NotificationContent(
                          category: NotificationCategory.Reminder,
                          wakeUpScreen: true,
                          id: int.parse(Get.find<BirthdayController>()
                              .number
                              .value
                              .substring(3)),
                          channelKey: 'chanel',
                          title: 'Daily Tasks'.tr,
                          body:
                              '${Get.find<BirthdayController>().nameCon.text} ${'s birthday is today!'.tr}',
                        ),
                      );
                    }
                    Get.snackbar(
                      'Good!'.tr,
                      '${Get.find<BirthdayController>().mounth.value}.${Get.find<BirthdayController>().day.value} ${'We will let you know on'.tr}',
                      margin: const EdgeInsets.all(20),
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                      icon: const Icon(
                        Icons.cake_sharp,
                        color: Colors.white,
                      ),
                    );
                    Get.find<BirthdayController>().nameCon.text = '';
                    Get.find<BirthdayController>().numberCon.text = '';
                    Get.find<BirthdayController>().day.value = 0;
                    Get.find<BirthdayController>().mounth.value = 0;
                    Get.find<BirthdayController>().year.value = 0;
                  } else {
                    Get.snackbar(
                      'Error!'.tr,
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
                        AwesomeNotifications().cancel(
                          int.parse(
                            Get.find<BirthdayController>()
                                .number
                                .value
                                .substring(3),
                          ),
                        );

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
                  style: const TextStyle(color: Colors.white70),
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
