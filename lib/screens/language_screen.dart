import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

int selectedLang = 0;
List langs = [
  'English',
  'Persian',
];
void setLanguage(String lang) async {
  SharedPreferences prefLanguage = await SharedPreferences.getInstance();
  prefLanguage.setString("language", lang);
  // setState(() {
  //   language = lang;
  // });
}

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBarWidget(
        action: false,
        back: true,
        titleText: "Set Language",
        svgIcon: 'assets/back2.svg',
        fontSize: 46,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: Get.height / 5,
              ),
              SizedBox(
                height: Get.height / 3,
                width: Get.width - 40,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // setState(() {
                            //   selectedLang = index;
                            //   if (index == 0) {
                            //     setLanguage('en');
                            //     Navigator.pop(context);
                            //   } else {
                            //     setLanguage('fa');
                            //     Navigator.pop(context);
                            //   }
                            // });
                          },
                          child: Container(
                            height: 50,
                            width: Get.width / 3,
                            decoration: BoxDecoration(
                              color: selectedLang == index
                                  ? Colors.teal
                                  : Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                langs[index],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: Get.height / 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
