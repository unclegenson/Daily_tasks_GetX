import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:daily_tasks_getx/controllers/category_controller.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart' as h;

import 'package:daily_tasks_getx/controllers/image_controller.dart';
import 'package:daily_tasks_getx/controllers/task_controller.dart';
import 'package:daily_tasks_getx/controllers/text_field_controller.dart';
import 'package:daily_tasks_getx/controllers/user_info_controller.dart';
import 'package:daily_tasks_getx/models/general_models.dart';
import 'package:daily_tasks_getx/screens/home.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound/flutter_sound.dart';

int selectedTaskIndex = 0;
List categoryItems = ['WorkOut', 'Shopping', 'Work', 'Studing'];
final picker = ImagePicker();
final recorder = FlutterSoundRecorder();
final audioPlayer = AudioPlayer();

void _openDialog(String title, Widget content) {
  Get.defaultDialog(
    title: title,
    content: content,
    cancel: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text(
        'cancel'.tr,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    confirm: TextButton(
      onPressed: () {
        Get.back();
      },
      child: Text(
        'Sumbit'.tr,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
}

Future showOptions() async {
  Get.defaultDialog(
    backgroundColor: Colors.transparent,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Color.fromARGB(
              Get.find<UserInfoController>().selectedColorAlpha.value,
              Get.find<UserInfoController>().selectedColorRed.value,
              Get.find<UserInfoController>().selectedColorGreen.value,
              Get.find<UserInfoController>().selectedColorBlue.value,
            ),
          ),
          child: Text(
            'Gallery'.tr,
            style: const TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Get.find<ImageController>().getImage(ImageSource.gallery);
          },
        ),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Get.find<UserInfoController>().buttonColor,
          ),
          child: Text(
            'Camera'.tr,
            style: const TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Get.find<ImageController>().getImage(ImageSource.camera);
          },
        ),
      ],
    ),
  );
}

Color? _shadeColor = Colors.blue[800];
Color? selectedColor;

void setColor() {
  var task = Get.find<TaskController>();

  task.colorAlpha.value = selectedColor!.alpha;
  task.colorBlue.value = selectedColor!.blue;
  task.colorGreen.value = selectedColor!.green;
  task.colorRed.value = selectedColor!.red;
}

void _openColorPicker() async {
  _openDialog(
    '',
    MaterialColorPicker(
      selectedColor: _shadeColor,
      onColorChange: (color) {
        selectedColor = color;
        setColor();
      },
    ),
  );
}

Future record() async {
  int id = Get.find<TaskController>().index;
  await recorder.startRecorder(toFile: 'audio${id.toString()}');
}

Future stop() async {
  final path = await recorder.stopRecorder();
  Get.find<TaskController>().pathOfVoice.value = path!;
  setAudio();
}

Future setAudio() async {
  audioPlayer.setSourceDeviceFile(Get.find<TaskController>().pathOfVoice.value);
}

Future<void> initRecorder() async {
  Permission.microphone.request();

  await recorder.openRecorder();
  recorder.setSubscriptionDuration(const Duration(milliseconds: 200));
}

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  void initState() {
    if (Get.find<CategoryController>().categories.isNotEmpty) {
      for (var i = 0;
          i < Get.find<CategoryController>().categories.length;
          i++) {
        categoryItems
            .add(Get.find<CategoryController>().categories[i].category);
      }
    }
    audioPlayer.onPlayerStateChanged.listen(
      (event) {
        if (mounted) {
          Get.find<TaskController>().isPlaying.value =
              // ignore: unrelated_type_equality_checks
              event == h.PlayerState.isPlaying;
        }
      },
    );
    audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        Get.find<TaskController>().durationOfAudio.value = newDuration;
      }
    });
    audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        Get.find<TaskController>().position.value = newPosition;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setTime();
    selectedColor = colorItems[Random().nextInt(colorItems.length)];
    setColor();
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBarWidget(
        action: true,
        back: true,
        titleText: Get.find<TaskController>().isEditing
            ? "Edit Task".tr
            : "Add Task".tr,
        svgIcon: 'assets/back2.svg',
        fontSize: 46,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: Get.width,
            height: Get.height * 5 / 6,
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  !Get.find<TaskController>().micOn.value
                      ? const Column(
                          children: [
                            TitleWidget(),
                            SizedBox(
                              height: 14,
                            ),
                            CategoryWidget(),
                            SizedBox(
                              height: 14,
                            ),
                            DescriptionWidget(),
                          ],
                        )
                      : Column(
                          children: [
                            Text(
                              Get.find<TaskController>().isRecording.value
                                  ? 'recordeing...'.tr
                                  : 'Click the mic button to start recording...'
                                      .tr,
                              style: TextStyle(
                                color:
                                    Get.find<UserInfoController>().buttonColor,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            StreamBuilder(
                              stream: recorder.onProgress,
                              builder: (_, snapshot) {
                                final duration = snapshot.hasData
                                    ? snapshot.data!.duration
                                    : Duration.zero;

                                String twoDigits(int n) =>
                                    n.toString().padLeft(2);
                                final twoDigitMinutes =
                                    twoDigits(duration.inMinutes.remainder(60));
                                final twoDigitSeconds =
                                    twoDigits(duration.inSeconds.remainder(60));

                                return Text(
                                  '$twoDigitMinutes :$twoDigitSeconds',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 26),
                                );
                              },
                            ),
                            Slider(
                              activeColor:
                                  Get.find<UserInfoController>().buttonColor,
                              divisions: 20,
                              value: Get.find<TaskController>()
                                  .position
                                  .value
                                  .inSeconds
                                  .toDouble(),
                              onChanged: (value) async {
                                final position =
                                    Duration(seconds: value.toInt());
                                await audioPlayer.seek(position);
                              },
                              min: 0,
                              max: Get.find<TaskController>()
                                  .durationOfAudio
                                  .value
                                  .inSeconds
                                  .toDouble(),
                            ),
                            const AudioPositionsWidget(),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RecordIconButton(),
                                ResumeIconButtion(),
                                PauseIconButton()
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            const TitleWidget(),
                          ],
                        ),
                  const ImagePickerWidget(),
                  const Row(
                    children: [
                      ColorPickerWidget(),
                      Spacer(),
                      CalenderWidget(),
                    ],
                  ),
                  const CreateTaskWidget(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class AudioPositionsWidget extends StatelessWidget {
  const AudioPositionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            // position.inSeconds.toString(),
            'start'.tr,
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            // durationOfAudio.inSeconds.toString(),
            "end".tr,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class CreateTaskWidget extends StatelessWidget {
  const CreateTaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Get.find<TaskController>().isEditing) {
          var task = Get.find<TaskController>()
              .tasks[Get.find<TaskController>().index.toInt()];
          //
          task.title = Get.find<TextFieldController>().taskTitle!.text;
          task.description = Get.find<TextFieldController>().taskDesc!.text;
          task.category = Get.find<TextFieldController>().cat;
          task.colorAlpha = Get.find<TaskController>().colorAlpha.value;
          task.colorBlue = Get.find<TaskController>().colorBlue.value;
          task.colorGreen = Get.find<TaskController>().colorGreen.value;
          task.colorRed = Get.find<TaskController>().colorRed.value;
          task.image = Get.find<TaskController>().image.value;
          task.voice = Get.find<TaskController>().pathOfVoice.value;
          //
          task.year = Get.find<TaskController>().year.value;
          task.month = Get.find<TaskController>().month.value;
          task.day = Get.find<TaskController>().day.value;
          task.hour = Get.find<TaskController>().hour.value;
          task.minute = Get.find<TaskController>().minute.value;
          task.weekDay = Get.find<TaskController>().weekDay.value;
          //
          Get.find<TaskController>()
              .tasks[Get.find<TaskController>().index.toInt()] = task;
          //
        } else {
          final now = DateTime.now();
          Get.find<TaskController>().tasks.add(
                TasksModel(
                  category: Get.find<TextFieldController>().cat,
                  colorAlpha: Get.find<TaskController>().colorAlpha.value,
                  day: now.day,
                  description: Get.find<TextFieldController>().taskDesc!.text,
                  done: false,
                  hour: now.hour,
                  minute: now.minute,
                  month: now.month,
                  title: Get.find<TextFieldController>().taskTitle!.text,
                  weekDay: now.weekday,
                  year: now.year,
                  colorRed: Get.find<TaskController>().colorRed.value,
                  colorBlue: Get.find<TaskController>().colorBlue.value,
                  colorGreen: Get.find<TaskController>().colorGreen.value,
                  image: Get.find<ImageController>().imagePath.value,
                  voice: Get.find<TaskController>().pathOfVoice.value,
                  audioId: Get.find<TaskController>().audioId.value,
                ),
              );
        }
        // AwesomeNotifications().createNotification(
        //   schedule: NotificationCalendar(
        //     day: time.day,
        //     hour: time.hour,
        //     minute: time.minute - 1,
        //     month: time.month,
        //     year: time.year,
        //   ),
        //   content: NotificationContent(
        //     category: NotificationCategory.Reminder,
        //     wakeUpScreen: true,
        //     color: selectedColor,
        //     id: 10,
        //     channelKey: 'chanel',
        //     title: 'Daily Tasks',
        //     body: 'time of $mainTitleText is now!',
        //   ),
        // );
        Get.find<ImageController>().imagePath.value = '';
        Get.back();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Get.find<UserInfoController>().buttonColor,
        ),
        width: Get.width - 30,
        height: 60,
        child: Center(
          child: Text(
            Get.find<TaskController>().isEditing
                ? 'Edit Task'.tr
                : 'Create Task'.tr,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openColorPicker,
      child: Container(
        decoration: BoxDecoration(
          color: Get.find<UserInfoController>().buttonColor,
          borderRadius: BorderRadius.circular(20),
        ),
        width: Get.width / 2 - 25,
        height: 100,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Pick a Color'.tr,
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(
                width: 6,
              ),
              const Icon(
                Icons.imagesearch_roller_rounded,
                size: 18,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showOptions();
      },
      child: Container(
          height: 160,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white70, width: 0.4),
          ),
          child: Obx(
            () {
              return Stack(
                children: [
                  Get.find<ImageController>().imagePath.value == ''
                      ? const SizedBox()
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Obx(
                                () {
                                  return Image.file(
                                    File(Get.find<ImageController>()
                                        .imagePath
                                        .value),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18, top: 18, right: 18),
                    child: Text(
                      'Attach an Image'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}

class RecordIconButton extends StatelessWidget {
  const RecordIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        if (recorder.isRecording) {
          await stop();
          // isRecording = false;
        } else {
          await record();
          // isRecording = true;
        }
      },
      icon: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        width: 40,
        height: 40,
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          width: 40,
          height: 40,
          child: !Get.find<TaskController>().isRecording.value
              ? const Icon(
                  Icons.mic,
                  color: Colors.black,
                )
              : const Icon(
                  Icons.square,
                  color: Colors.black,
                ),
        ),
      ),
    );
  }
}

class PauseIconButton extends StatelessWidget {
  const PauseIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        audioPlayer.pause();
      },
      icon: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        width: 40,
        height: 40,
        child: const Icon(
          Icons.pause,
          color: Colors.black,
        ),
      ),
    );
  }
}

class ResumeIconButtion extends StatelessWidget {
  const ResumeIconButtion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (Get.find<TaskController>().pathOfVoice.value != '') {
          setAudio();
          audioPlayer.resume();
        }
      },
      icon: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        width: 40,
        height: 40,
        child: const Icon(
          Icons.play_arrow,
          color: Colors.black,
        ),
      ),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width - 30,
      child: TextFormField(
        initialValue: mainDescriptionText,
        controller: Get.find<TextFieldController>().taskDesc,
        onChanged: (value) {
          Get.find<TextFieldController>().taskDesc!.text = value;
        },
        maxLines: 3,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          hintText: 'description'.tr,
          prefixText: '  ',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      style: const TextStyle(color: Colors.white),
      isExpanded: true,
      decoration: InputDecoration(
        iconColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      hint: Text(
        'category'.tr,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
      items: categoryItems
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(color: Colors.white),
                ),
              ))
          .toList(),
      onChanged: (value) {
        // setState(() {
        //   selectedCategory = value.toString();
        // });
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 4, left: 4),
      ),
      iconStyleData: const IconStyleData(
        icon: Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 3),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
          ),
        ),
        iconSize: 22,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width - 30,
      child: TextFormField(
        controller: Get.find<TextFieldController>().taskTitle,
        initialValue: mainTitleText,
        onChanged: (value) {
          Get.find<TextFieldController>().taskTitle!.text = value;
        },
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          hintText: 'title'.tr,
          prefixText: '  ',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
