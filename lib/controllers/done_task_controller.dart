import 'package:daily_tasks_getx/models/general_models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DoneTaskController extends GetxController {
  var doneTasks = <TasksModel>[].obs;
  var index = 0;

  var colorAlpha = 0.obs;
  var colorRed = 0.obs;
  var colorGreen = 0.obs;
  var colorBlue = 0.obs;

  var category = ''.obs;
  var done = false.obs;

  var day = 0.obs;
  var month = 0.obs;
  var year = 0.obs;

  var image = ''.obs;
  var voice = ''.obs;

  @override
  void onInit() {
    var box = GetStorage();

    if (box.read('done_tasks') != null) {
      var tasksList = box.read('done_tasks');
      for (var taskItem in tasksList) {
        doneTasks.add(TasksModel.fromJson(taskItem));
      }
    }

    ever(doneTasks, (callback) {
      box.write('tasks', doneTasks.toJson());
    });
    super.onInit();
  }
}
