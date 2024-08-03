import 'package:daily_tasks_getx/screens/add_birthday_screen.dart';
import 'package:daily_tasks_getx/screens/add_category.dart';
import 'package:daily_tasks_getx/screens/go_premium.dart';
import 'package:daily_tasks_getx/screens/review_tasks_screen.dart';
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
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Uncle Gen Son',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'title',
                        fontWeight: FontWeight.w600,
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
                const Text(
                  '+98 910 063 9128',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
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
              Get.to(() => ReviewScreen());
            },
            leading: const Icon(
              Icons.bar_chart_rounded,
              color: Colors.black,
            ),
            title: const Text('Review Tasks'),
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
            title: const Text('Premium V.'),
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
            title: const Text('Set Categories'),
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
            title: const Text('Set Birthdays'),
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -2),
            onTap: () {},
            leading: const Icon(
              Icons.coffee_rounded,
              color: Colors.black,
            ),
            title: const Text('Buy me a Coffee'),
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
            title: const Text('Settings'),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            visualDensity: const VisualDensity(vertical: -2),
            onTap: () async {
              await Share.share('Check Out This App');
            },
            leading: const Icon(
              Icons.person_add,
              color: Colors.black,
            ),
            title: const Text('Invite Friends'),
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
            title: const Text('Contact Us'),
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
    query:
        'subject=App Feedback&body=App Version 1.0:\n\nThe problem is ', //add subject and body here
  );

  // var url = params.toString();

  if (await canLaunchUrl(params)) {
    await launchUrl(params);
  } else {
    Get.snackbar('error', 'error while emailing unclegenson@gmail.com');
  }
}
