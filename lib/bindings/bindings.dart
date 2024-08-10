import 'package:daily_tasks_getx/controllers/birthday_controller.dart';
import 'package:daily_tasks_getx/controllers/category_controller.dart';
import 'package:daily_tasks_getx/controllers/done_task_controller.dart';
import 'package:daily_tasks_getx/controllers/image_controller.dart';
import 'package:daily_tasks_getx/controllers/task_controller.dart';
import 'package:daily_tasks_getx/controllers/text_field_controller.dart';
import 'package:daily_tasks_getx/controllers/trasnlate_cntroller.dart';
import 'package:daily_tasks_getx/controllers/user_info_controller.dart';
import 'package:get/get.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskController());
    Get.put(TextFieldController());
    Get.put(ImageController());
    Get.put(UserInfoController());
    Get.put(TrasnlateController());
    Get.put(DoneTaskController());
    Get.put(CategoryController());
    Get.put(BirthdayController());
  }
}
