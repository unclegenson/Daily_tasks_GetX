import 'package:bottom_picker/bottom_picker.dart';
import 'package:daily_tasks_getx/controllers/task_controller.dart';
import 'package:daily_tasks_getx/controllers/user_info_controller.dart';
import 'package:daily_tasks_getx/screens/add_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
      titleSpacing: 10,
      leading: Builder(
        builder: (context) {
          return InkWell(
            onTap: () {
              back ? Get.back() : Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[800],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    svgIcon,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcATop,
                    ),
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
                padding: const EdgeInsets.only(
                  right: 8,
                ),
                child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[800],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () async {
                        // SharedPreferences premium =
                        //     await SharedPreferences.getInstance();
                        // if (premium.getBool('purchase')!) {
                        //   //todo: ! here
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text(
                        //         AppLocalizations.of(context)!
                        //             .youAreNotAPremiumContact,
                        //       ),
                        //       duration: const Duration(milliseconds: 2500),
                        //     ),
                        //   );
                        // } else {
                        //   if (micOn == true) {
                        //     setState(() {
                        //       micOn = false;
                        //     });
                        //   } else {
                        //     setState(() {
                        //       micOn = true;
                        //     });
                        //   }
                        // }
                      },
                      child: Icon(
                        micOn ? Icons.mic : Icons.mic_off_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ],
      elevation: 0,
      toolbarHeight: 100,
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
      'choose Task Date',
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
        'Task Notification will be in: ',
        '${day != 0 ? '$day days' : ''} ${hour.toString().length > 1 ? '$hour' : '0$hour'} hours ${minute.toString().length > 1 ? '$minute' : '0$minute'} minutes from now!',
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 6),
      );
    },
    onChange: (p0) {
      var task = Get.find<TaskController>();
      time = p0;
      task.day.value = time.day;
      task.hour.value = time.hour;
      task.minute.value = time.minute;
      task.month.value = time.month;
      task.weekDay.value = time.weekday;
      task.year.value = time.year;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.edit_calendar,
              ),
              Text(
                '${time.day.toString()} - ${time.month.toString()} - ${time.year.toString()}',
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                '${time.hour.toString().length > 1 ? time.hour.toString() : '0${time.hour.toString()}'} : ${time.minute.toString().length > 1 ? time.minute.toString() : '0${time.minute.toString()}'} ',
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? mainDescriptionText;

String? mainTitleText;
