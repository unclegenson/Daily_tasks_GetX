import 'dart:io';

import 'package:daily_tasks_getx/controllers/user_info_controller.dart';
import 'package:daily_tasks_getx/screens/add_birthday_screen.dart';
import 'package:daily_tasks_getx/screens/add_category.dart';
import 'package:daily_tasks_getx/screens/go_premium.dart';
import 'package:daily_tasks_getx/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[300],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => CircleAvatar(
                      backgroundColor:
                          Get.find<UserInfoController>().buttonColor,
                      backgroundImage: FileImage(
                        File(Get.find<UserInfoController>().image.value),
                      ),
                      radius: Get.width / 5,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        Get.find<UserInfoController>().name.value,
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: 'title',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                  ],
                ),
                Obx(
                  () => Text(
                    Get.find<UserInfoController>().number.value,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -2),
            onTap: () {
              // Get.to(() => ReviewScreen());
            },
            leading: const Icon(
              Icons.bar_chart_rounded,
              color: Colors.black,
            ),
            title: Text('Review'.tr),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -2),
            onTap: () {
              Get.to(() => GoPremiumScreen());
            },
            leading: const Icon(
              Icons.beach_access_rounded,
              color: Colors.black,
            ),
            title: Text('Premium V.'.tr),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -2),
            onTap: () {
              Get.to(() => AddCategoryScreen());
            },
            leading: const Icon(
              Icons.category_rounded,
              color: Colors.black,
            ),
            title: Text('Set Categories'.tr),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -2),
            onTap: () {
              Get.to(() => AddBirthdayScreen());
            },
            leading: const Icon(
              Icons.cake_sharp,
              color: Colors.black,
            ),
            title: Text('Set Birthdays'.tr),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -2),
            onTap: () {
              Get.back();
              Get.snackbar(
                'Navigating to purchase page',
                'Make sure your internet connection is active! You will be in purchase page in 5 seconds!',
                colorText: Colors.white,
                margin: EdgeInsets.all(15),
                duration: Duration(seconds: 7),
                icon: Icon(
                  Icons.wifi,
                  color: Colors.orange,
                ),
                snackPosition: SnackPosition.BOTTOM,
              );
              Get.snackbar(
                'Successfull',
                'Your purchase was successfull. Thanks!',
                colorText: Colors.white,
                margin: EdgeInsets.all(15),
                duration: Duration(seconds: 4),
                icon: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            leading: const Icon(
              Icons.coffee_rounded,
              color: Colors.black,
            ),
            title: Text('Buy me a Coffee'.tr),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -2),
            onTap: () {
              Get.to(() => SettingsScreen());
            },
            leading: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: Text('Settings'.tr),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -2),
            onTap: () async {
              await Share.share('Check Out This App'.tr);
            },
            leading: const Icon(
              Icons.person_add,
              color: Colors.black,
            ),
            title: Text('Invite Friends'.tr),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -2),
            onTap: () {
              _openUrl();
            },
            leading: const Icon(
              Icons.bubble_chart_rounded,
              color: Colors.black,
            ),
            title: Text('Contact Us'.tr),
          ),
        ],
      ),
    );
  }
}

Future<void> _openUrl() async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: 'unclegenson@gmail.com',
    query: 'subject=App Feedback&body=App Version 1.0:\n\nThe problem is '.tr,
  );

  if (await canLaunchUrl(params)) {
    await launchUrl(params);
  } else {
    Get.snackbar(
      'error'.tr,
      'error while emailing unclegenson@gmail.com'.tr,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      margin: const EdgeInsets.all(20),
    );
  }
}
