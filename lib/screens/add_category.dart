import 'package:daily_tasks_getx/controllers/user_info_controller.dart';
import 'package:daily_tasks_getx/screens/settings_screen.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String? newCategory = '';
TextEditingController con = TextEditingController();

bool wantToChange = false;
int indexx = 0;
List categoryItems = [];

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBarWidget(
        action: false,
        back: true,
        titleText: "Set Categories".tr,
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
                SizedBox(
                  height: Get.height * 6 / 10,
                  child: ListView.builder(
                    itemCount: categoryItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.only(left: 8),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // setState(() {
                            //   wantToChange = true;
                            //   indexx = index;
                            //   newCategory = categoryItems[index];
                            //   con.text = newCategory!;
                            // });
                          },
                        ),
                        title: Text(
                          categoryItems[index],
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
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
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: SettingsCategoryWidget(
                    color: Colors.white,
                    text:
                        !wantToChange ? 'Add Category'.tr : 'Edit Category'.tr,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
                  child: TextFormField(
                    controller: con,
                    onChanged: (value) {
                      // setState(() {
                      //   newCategory = value;
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
                    onPressed: () {
                      if (wantToChange) {
                        if (newCategory != '') {
                          // setState(() {
                          //   categoryItems.add(newCategory);
                          //   categoryItems.removeAt(indexx);
                          // });
                          // Hive.box<Categories>('categoryBox')
                          //     .putAt(indexx, Categories(name: newCategory));
                          Get.back();
                        } else {
                          Get.snackbar(
                            'error!'.tr,
                            'Edit the Task please'.tr,
                            margin: EdgeInsets.all(20),
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      } else {
                        if (newCategory != '') {
                          // setState(() {
                          //   categoryItems.add(newCategory);
                          // });
                          // Hive.box<Categories>('categoryBox')
                          //     .add(Categories(name: newCategory));
                          Get.back();
                        } else {
                          Get.snackbar(
                            'error!'.tr,
                            'nothing Added'.tr,
                            margin: EdgeInsets.all(20),
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      }
                    },
                    child: Text(
                      'Save'.tr,
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
