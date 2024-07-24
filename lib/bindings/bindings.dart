import 'package:daily_tasks_getx/controllers/task_controllers.dart';
import 'package:daily_tasks_getx/controllers/text_field_controller.dart';
import 'package:get/get.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskController());
    Get.put(TextFieldController());
  }
}
