import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';
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
                        true ? Icons.mic : Icons.mic_off_rounded,
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
      toolbarHeight: 70,
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

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({
    super.key,
  });

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

bool showTime = false;
DateTime time = DateTime.now();

class _CalenderWidgetState extends State<CalenderWidget> {
  @override
  Widget build(BuildContext context) {
    void openDateTimePicker(BuildContext context) {
      BottomPicker.dateTime(
        pickerTitle: Text(
          'choose Task Date',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.orange,
          ),
        ),
        gradientColors: [Colors.orange, Colors.blue],
        backgroundColor: Colors.black87,
        closeIconColor: Colors.orange,
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  '${day != 0 ? '$day days' : ''} ${hour.toString().length > 1 ? '$hour' : '0$hour'} hours ${minute.toString().length > 1 ? '$minute' : '0$minute'} minutes from now!'),
            ),
          );
        },
        onChange: (p0) {
          setState(() {
            time = p0;
            showTime = true;
          });
        },
      ).show(context);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 1500),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(20),
      ),
      width: Get.width / 2 - 20,
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

class DescriptionInputWidget extends StatefulWidget {
  const DescriptionInputWidget({
    super.key,
    required this.size,
    required this.descriptionText,
  });
  final String descriptionText;

  final Size size;

  @override
  State<DescriptionInputWidget> createState() => _DescriptionInputWidgetState();
}

class _DescriptionInputWidgetState extends State<DescriptionInputWidget> {
  @override
  void initState() {
    setState(() {
      mainDescriptionText = widget.descriptionText;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width - 30,
      child: TextFormField(
        initialValue: mainDescriptionText,
        onChanged: (value) {
          setState(() {
            mainDescriptionText = value;
          });
        },
        maxLines: 3,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          hintText: 'description',
          prefixText: '  ',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

String? mainTitleText;

class TitleInputWidget extends StatefulWidget {
  const TitleInputWidget({
    super.key,
    required this.size,
    required this.titleText,
  });

  final String titleText;
  final Size size;

  @override
  State<TitleInputWidget> createState() => _TitleInputWidgetState();
}

class _TitleInputWidgetState extends State<TitleInputWidget> {
  @override
  void initState() {
    setState(() {
      mainTitleText = widget.titleText;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width - 30,
      child: TextFormField(
        initialValue: mainTitleText,
        onChanged: (value) {
          setState(() {
            mainTitleText = value;
          });
        },
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          hintText: 'title',
          prefixText: '  ',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
