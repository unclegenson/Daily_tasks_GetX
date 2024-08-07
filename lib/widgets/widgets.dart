import 'package:bottom_picker/bottom_picker.dart';
import 'package:daily_tasks_getx/controllers/task_controller.dart';
import 'package:daily_tasks_getx/controllers/user_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

void setTime() {
  var task = Get.find<TaskController>();
  task.day.value = time.day;
  task.hour.value = time.hour;
  task.minute.value = time.minute;
  task.month.value = time.month;
  task.weekDay.value = time.weekday;
  task.year.value = time.year;
}

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.titleText,
    required this.fontSize,
    required this.svgIcon,
    required this.back,
    required this.action,
  });
  final String titleText;
  final double fontSize;
  final String svgIcon;
  final bool back;
  final bool action;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Colors.black,
      ),
      leadingWidth: 65,
      leading: Builder(
        builder: (context) {
          return InkWell(
            onTap: () {
              back ? Get.back() : Scaffold.of(context).openDrawer();
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[800],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  svgIcon,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcATop,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      actions: [
        action
            ? Padding(
                padding: const EdgeInsets.only(right: 8, left: 8, top: 4),
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[800],
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Obx(() {
                        return InkWell(
                          onTap: () async {
                            var micOn = Get.find<TaskController>().micOn;
                            if (micOn.value == true) {
                              micOn.value = false;
                            } else {
                              micOn.value = true;
                            }
                          },
                          child: Icon(
                            Get.find<TaskController>().micOn.value
                                ? Icons.mic
                                : Icons.mic_off_rounded,
                            size: 30,
                            color: Colors.white,
                          ),
                        );
                      })),
                ),
              )
            : Container(),
      ],
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.black87,
      title: Text(
        titleText,
        style: TextStyle(
            fontSize: fontSize, fontFamily: 'title', color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

bool showTime = false;
DateTime time = DateTime.now();
void openDateTimePicker(BuildContext context) {
  BottomPicker.dateTime(
    pickerTitle: Text(
      'Choose Task Date'.tr,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Get.find<UserInfoController>().buttonColor,
      ),
    ),
    gradientColors: [Get.find<UserInfoController>().buttonColor!, Colors.blue],
    backgroundColor: Colors.black87,
    closeIconColor: Get.find<UserInfoController>().buttonColor!,
    initialDateTime: DateTime.now(),
    maxDateTime: DateTime(2030),
    minDateTime: DateTime(DateTime.now().year),
    pickerTextStyle: const TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    onSubmit: (p0) {
      time = p0;
      var day = DateTime(time.year, time.month, time.day)
          .difference(DateTime.now())
          .inDays;
      int hour = DateTime(time.year, time.month, time.day, time.hour).hour -
          DateTime.now().hour;
      int minute =
          DateTime(time.year, time.month, time.day, time.hour, time.minute)
                  .minute -
              DateTime.now().minute;
      Get.snackbar(
        'Task Notification will be in: '.tr,
        '${day != 0 ? '$day days' : ''} ${hour.toString().length > 1 ? '$hour' : '0$hour'} hours ${minute.toString().length > 1 ? '$minute' : '0$minute'} minutes from now!'
            .tr,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 6),
      );
    },
    onChange: (p0) {
      time = p0;
      setTime();
      print(time);
    },
  ).show(context);
}

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.find<UserInfoController>().buttonColor,
        borderRadius: BorderRadius.circular(20),
      ),
      width: Get.width / 2 - 25,
      height: 100,
      child: InkWell(
        onTap: () {
          return openDateTimePicker(context);
        },
        child: Center(
          child: Obx(
            () {
              var task = Get.find<TaskController>();

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.edit_calendar,
                  ),
                  Text(
                    '${task.day.value.toString()} - ${task.month.value.toString()} - ${task.year.value.toString()}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    '${task.hour.value.toString().length > 1 ? task.hour.value.toString() : '0${task.hour.value.toString()}'} : ${task.minute.value.toString().length > 1 ? task.minute.value.toString() : '0${task.minute.value.toString()}'} ',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

String? mainDescriptionText;

String? mainTitleText;
