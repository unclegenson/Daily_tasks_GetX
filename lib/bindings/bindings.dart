import 'package:daily_tasks_getx/controllers/image_controller.dart';
import 'package:daily_tasks_getx/controllers/task_controller.dart';
import 'package:daily_tasks_getx/controllers/text_field_controller.dart';
import 'package:get/get.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(TaskController());
    Get.put(TextFieldController());
    Get.put(ImageController());
  }
}
