import 'package:daily_tasks_getx/models/hive_models.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  var isEditing = false.obs;
  var tasks = <Tasks>[].obs;
  var index = 0;
}
