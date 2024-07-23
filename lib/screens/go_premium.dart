import 'package:daily_tasks_getx/screens/settings_screen.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

List premiumOptions = [
  'Notifications',
  'Birthday messages - sms',
  'Attach image for each task',
  'voice tasks',
  'sharing review table',
  'special themes',
];

class GoPremiumScreen extends StatelessWidget {
  const GoPremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: const AppBarWidget(
          action: false,
          back: true,
          titleText: "Go Premium",
          svgIcon: 'assets/back2.svg',
          fontSize: 46,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: Get.height * 8.2 / 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: SettingsCategoryWidget(
                        color: Colors.white, text: 'Premium Options :'),
                  ),
                  SizedBox(
                    height: Get.height * 6 / 10,
                    child: ListView.builder(
                      itemCount: premiumOptions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: const EdgeInsets.only(left: 8),
                          title: Text(
                            premiumOptions[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
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
                  const Padding(
                    padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SettingsCategoryWidget(
                              color: Colors.white,
                              text: 'Premium version price :',
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'for each month',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '69.000',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  ' تومان',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              '83.000',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: Get.width - 40,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Purchase',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
