import 'package:daily_tasks_getx/controllers/category_controller.dart';
import 'package:daily_tasks_getx/controllers/user_info_controller.dart';
import 'package:daily_tasks_getx/models/general_models.dart';
import 'package:daily_tasks_getx/screens/settings_screen.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

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
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShowCategories(),
                SizedBox(
                  height: 4,
                ),
                Divider(
                  thickness: 3,
                ),
                AddOrEditWidget(),
                CategoryTextField(),
                Spacer(),
                Buttons()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(() {
          return SizedBox(
            width: Get.find<CategoryController>().wantToChange.value == false
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
              onPressed: () {
                if (Get.find<CategoryController>().wantToChange.value) {
                  if (Get.find<CategoryController>().category.value != '') {
                    Get.find<CategoryController>().categories.add(
                          CategoriesModel(
                            category:
                                Get.find<CategoryController>().category.value,
                          ),
                        );
                    Get.find<CategoryController>()
                        .categories
                        .removeAt(Get.find<CategoryController>().index);
                  } else {
                    Get.snackbar(
                      'error!'.tr,
                      'Edit the Task please'.tr,
                      margin: const EdgeInsets.all(20),
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                    );
                  }
                } else {
                  if (Get.find<CategoryController>().category.value != '') {
                    Get.find<CategoryController>().categories.add(
                          CategoriesModel(
                            category:
                                Get.find<CategoryController>().category.value,
                          ),
                        );
                    Get.find<CategoryController>().con.text = '';
                  } else {
                    Get.snackbar(
                      'error!'.tr,
                      'nothing Added'.tr,
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
            if (Get.find<CategoryController>().wantToChange.value == true) {
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
                      title: 'Delete This Category'.tr,
                      message:
                          'Are you sure you want to delete this Category?'.tr,
                      confirmButtonText: 'Yes'.tr,
                      cancelButtonText: 'No'.tr,
                      onTapCancel: () {
                        Navigator.pop(context);
                      },
                      onTapConfirm: () {
                        Get.find<CategoryController>()
                            .categories
                            .removeAt(Get.find<CategoryController>().index);
                        Get.find<CategoryController>().con.text = '';
                        Get.find<CategoryController>().wantToChange.value =
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

class CategoryTextField extends StatelessWidget {
  const CategoryTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
      child: TextFormField(
        controller: Get.find<CategoryController>().con,
        onChanged: (value) {
          Get.find<CategoryController>().category.value = value;
          if (Get.find<CategoryController>().con.text == '' ||
              Get.find<CategoryController>().con.text == ' ') {
            Get.find<CategoryController>().wantToChange.value = false;
          }
        },
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class AddOrEditWidget extends StatelessWidget {
  const AddOrEditWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: SettingsCategoryWidget(
        color: Colors.white,
        text: !Get.find<CategoryController>().wantToChange.value
            ? 'Add Category'.tr
            : 'Edit Category'.tr,
      ),
    );
  }
}

class ShowCategories extends StatelessWidget {
  const ShowCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 6 / 10,
      child: Obx(
        () {
          return ListView.builder(
            itemCount: Get.find<CategoryController>().categories.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: const EdgeInsets.only(left: 8),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Get.find<CategoryController>().wantToChange.value = true;
                    Get.find<CategoryController>().index = index;
                    Get.find<CategoryController>().category.value =
                        Get.find<CategoryController>()
                            .categories[index]
                            .category!;
                    Get.find<CategoryController>().con.text =
                        Get.find<CategoryController>().category.value;
                  },
                ),
                title: Text(
                  Get.find<CategoryController>().categories[index].category!,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w300),
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
