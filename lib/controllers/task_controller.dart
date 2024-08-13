import 'package:daily_tasks_getx/models/general_models.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TaskController extends GetxController {
  var isEditing = false;
  var micOn = false.obs;
  var isRecording = false.obs;
  var tasks = <TasksModel>[].obs;
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
  var hour = 0.obs;
  var minute = 0.obs;
  var weekDay = 0.obs;

  var image = ''.obs;
  var voice = ''.obs;
  var audioId = 0.obs;
  var pathOfVoice = ''.obs;
  var isPlaying = false.obs;
  var durationOfAudio = Duration(seconds: 0).obs;
  var position = Duration(seconds: 0).obs;

  var homePathOfVoice = ''.obs;
  var homeDurationOfAudio = Duration(seconds: 0).obs;
  var homeAudioPosition = Duration(seconds: 0).obs;

  @override
  void onInit() {
    var box = GetStorage();

    if (box.read('tasks') != null) {
      var tasksList = box.read('tasks');
      for (var taskItem in tasksList) {
        tasks.add(TasksModel.fromJson(taskItem));
      }
    }

    ever(tasks, (callback) {
      box.write('tasks', tasks.toJson());
    });
    super.onInit();
  }
}
