import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:daily_tasks_getx/controllers/task_controllers.dart';
import 'package:daily_tasks_getx/controllers/text_field_controller.dart';
import 'package:daily_tasks_getx/models/hive_models.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

int selectedTaskIndex = 0;
List categoryItems = ['1', '2', '3'];
final picker = ImagePicker();

bool micOn = false;

void _openDialog(String title, Widget content) {
  Get.defaultDialog(
    title: title,
    content: content,
    cancel: TextButton(
      onPressed: () {
        Get.back();
      },
      child: const Text(
        'cancel',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
    confirm: TextButton(
      onPressed: () {
        Get.back();
      },
      child: const Text(
        'sumbit',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
}

Future showOptions() async {
  // SharedPreferences premium = await SharedPreferences.getInstance();
  // if (premium.getBool('purchase')!) {
  Get.showSnackbar(
    const GetSnackBar(
      message: 'youAreNotAPremiumContact',
      duration: Duration(milliseconds: 2500),
    ),
  );
  // } else {
  Get.defaultDialog(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.orange,
          ),
          child: const Text(
            'gallery',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            // close the options modal
            Get.back();
            // get image from gallery
            getImageFromCamera();
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
            backgroundColor: Colors.orange,
          ),
          child: const Text(
            'camera',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            // close the options modal
            Get.back();
            // get image from camera
            getImageFromCamera();
          },
        ),
      ],
    ),
  );
}

Future getImageFromCamera() async {
  final pickedFile = await picker.pickImage(source: ImageSource.camera);
  // setState(() {
  //   if (pickedFile != null) {
  //     _image = File(pickedFile.path); // for showing image
  //     imageString = pickedFile.path; // for hive
  //   }
  // });
}

void _openColorPicker() async {
  _openDialog(
    'colorPicker',
    const MaterialColorPicker(
        // selectedColor: _shadeColor,
        // onColorChange: (color) => setState(() => selectedColor = color),
        ),
  );
}

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // setState(() {
    //   if (pickedFile != null) {
    //     _image = File(pickedFile.path);
    //     imageString = pickedFile.path;
    //   }
    // });
  }

  // Future<void> initRecorder() async {
  //   final status = await Permission.microphone.request();

  //   await recorder.openRecorder();
  //   recorder.setSubscriptionDuration(const Duration(milliseconds: 200));
  // }

  // Future setAudio() async {
  //   audioPlayer.setSourceDeviceFile(pathOfVoice!);
  // }
  //   void _openColorPicker() async {
  //   _openDialog(
  //     AppLocalizations.of(context)!.colorPicker,
  //     MaterialColorPicker(
  //       selectedColor: _shadeColor,
  //       onColorChange: (color) => setState(() => selectedColor = color),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBarWidget(
        action: true,
        back: true,
        titleText: Get.find<TaskController>().isEditing.value
            ? "Edit Task"
            : "Add Task",
        svgIcon: 'assets/back2.svg',
        fontSize: 46,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: Get.width,
            height: Get.height - 130, //todo: fix this 130
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                !micOn
                    ? Column(
                        children: [
                          SizedBox(
                            width: Get.width - 30,
                            child: TextFormField(
                              controller:
                                  Get.find<TextFieldController>().taskTitle,
                              initialValue: mainTitleText,
                              onChanged: (value) {
                                // setState(() {
                                //   mainTitleText = value;
                                // });
                              },
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                                hintText: 'title',
                                prefixText: '  ',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          DropdownButtonFormField2(
                            style: const TextStyle(color: Colors.white),
                            isExpanded: true,
                            decoration: InputDecoration(
                              iconColor: Colors.white,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            hint: const Text(
                              // anythingToShow && widget.note.voice == ''
                              true ? 'note category' : 'category',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            items: categoryItems
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'pleaseSelectACategory';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              // setState(() {
                              //   selectedCategory = value.toString();
                              // });
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.only(right: 8),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                              ),
                              iconSize: 24,
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
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          SizedBox(
                            width: Get.width - 30,
                            child: TextFormField(
                              initialValue: mainDescriptionText,
                              controller:
                                  Get.find<TextFieldController>().taskDesc,
                              onChanged: (value) {
                                // setState(() {
                                //   mainDescriptionText = value;
                                // });
                              },
                              maxLines: 3,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                                hintText: 'description',
                                prefixText: '  ',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Text(
                            true ? 'recordeing' : 'clickTheButtons',
                            style: TextStyle(color: Colors.orange),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          // StreamBuilder(
                          //   stream: recorder.onProgress,
                          //   builder: (_, snapshot) {
                          //     final duration = snapshot.hasData
                          //         ? snapshot.data!.duration
                          //         : Duration.zero;

                          //     String twoDigits(int n) =>
                          //         n.toString().padLeft(2);
                          //     final twoDigitMinutes =
                          //         twoDigits(duration.inMinutes.remainder(60));
                          //     final twoDigitSeconds =
                          //         twoDigits(duration.inSeconds.remainder(60));

                          //     return Text(
                          //       '$twoDigitMinutes :$twoDigitSeconds',
                          //       style: const TextStyle(
                          //           color: Colors.white, fontSize: 26),
                          //     );
                          //   },
                          // ),
                          // Slider(
                          //   activeColor: Colors.orange,
                          //   divisions: 20,
                          //   value: position.inSeconds.toDouble(),
                          //   onChanged: (value) async {
                          //     final position = Duration(seconds: value.toInt());
                          //     await audioPlayer.seek(position);
                          //   },
                          //   min: 0,
                          //   max: durationOfAudio.inSeconds.toDouble(),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  // position.inSeconds.toString(),
                                  'start',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  // durationOfAudio.inSeconds.toString(),
                                  "end",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  // if (recorder.isRecording) {
                                  //   await stop();
                                  //   setState(() {
                                  //     isRecording = false;
                                  //   });
                                  // } else {
                                  //   await record();
                                  //   setState(() {
                                  //     isRecording = true;
                                  //   });
                                  // }
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
                                    child: true
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
                              ),
                              IconButton(
                                onPressed: () {
                                  // if (pathOfVoice != '') {
                                  //   setAudio();
                                  //   audioPlayer.resume();
                                  // }
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
                              ),
                              IconButton(
                                onPressed: () {
                                  // audioPlayer.pause();
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
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          SizedBox(
                            width: Get.width - 30,
                            child: TextFormField(
                              initialValue: mainTitleText,
                              onChanged: (value) {
                                // setState(() {
                                //   mainTitleText = value;
                                // });
                              },
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                                hintText: 'title',
                                prefixText: '  ',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                GestureDetector(
                  onTap: () {
                    // showOptions();
                  },
                  child: Container(
                    height: 160,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white70, width: 0.4),
                    ),
                    child: Stack(
                      children: [
                        // _image == null
                        true
                            ? const SizedBox()
                            : Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    // child: Image.file(
                                    //   _image!,
                                    // ),
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18, top: 18),
                          child: Text(
                            'attachAnImage',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _openColorPicker,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 1500),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: Get.width / 2 - 20,
                        height: 100,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'pickAColor',
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
                    ),
                    const Spacer(),
                    CalenderWidget(),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if (Get.find<TaskController>().isEditing.value) {
                      var task = Get.find<TaskController>()
                          .tasks[Get.find<TaskController>().index.toInt()];

                      task.title =
                          Get.find<TextFieldController>().taskTitle!.text;

                      task.description =
                          Get.find<TextFieldController>().taskDesc!.text;

                      Get.find<TaskController>()
                              .tasks[Get.find<TaskController>().index.toInt()] =
                          task;
                    } else {
                      Get.find<TaskController>().tasks.add(
                            Tasks(
                              category: '1',
                              colorAlpha: 100,
                              day: 1,
                              description: Get.find<TextFieldController>()
                                  .taskDesc!
                                  .text,
                              done: false,
                              hour: 1,
                              id: '1',
                              minute: 1,
                              month: 1,
                              title: Get.find<TextFieldController>()
                                  .taskDesc!
                                  .text,
                              weekDay: 1,
                              year: 1,
                              colorRed: 200,
                              colorBlue: 100,
                              colorGreen: 300,
                              image: null,
                              voice: 'voice',
                            ),
                          );
                    }
                    Get.back();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 1500),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: Colors.orange,
                    ),
                    width: Get.width - 30,
                    height: 60,
                    child: Center(
                      child: Text(
                        Get.find<TaskController>().isEditing.value
                            ? 'Edit Task'
                            : 'Create Task',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// line 554 
// onTap: () async {
//                     if (mainTitleText == '') {
//                       if (
//                           // pathOfVoice == '' && micOn
//                           true) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             duration: const Duration(milliseconds: 1500),
//                             behavior: SnackBarBehavior.fixed,
//                             content: Text('thereIsNoVoiceOrTitle'),
//                           ),
//                         );
//                       }
//                       if (
//                           // !micOn && mainDescriptionText == ''
//                           true) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             duration: const Duration(milliseconds: 1500),
//                             behavior: SnackBarBehavior.fixed,
//                             content: Text('thereIsNoTitleOrDescription'),
//                           ),
//                         );
//                       }
//                     } else {
//                       if (
//                           // anythingToShow
//                           false) {
//                         //   await Hive.box<Notes>('notesBox').putAt(
//                         //     int.parse(widget.note.id!),
//                         //     Notes(
//                         //       voice: pathOfVoice,
//                         //       image: imageString,
//                         //       category: selectedCategory,
//                         //       colorAlpha: selectedColor?.alpha,
//                         //       colorRed: selectedColor?.red,
//                         //       colorBlue: selectedColor?.blue,
//                         //       colorGreen: selectedColor?.green,
//                         //       day: time.day,
//                         //       description: mainDescriptionText,
//                         //       done: false,
//                         //       hour: time.hour,
//                         //       id: time.toString(),
//                         //       minute: time.minute,
//                         //       month: time.month,
//                         //       title: mainTitleText,
//                         //       weekDay: time.weekday,
//                         //       year: time.year,
//                         //     ),
//                         //   );
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             duration: const Duration(milliseconds: 1500),
//                             behavior: SnackBarBehavior.fixed,
//                             content: Text('taskEdited'),
//                           ),
//                         );
//                       } else {
//                         // await Hive.box<Notes>('notesBox').add(
//                         //   Notes(
//                         //     voice: pathOfVoice,
//                         //     image: imageString,
//                         //     category: selectedCategory,
//                         //     colorAlpha: selectedColor?.alpha,
//                         //     colorRed: selectedColor?.red,
//                         //     colorBlue: selectedColor?.blue,
//                         //     colorGreen: selectedColor?.green,
//                         //     day: time.day,
//                         //     description: mainDescriptionText,
//                         //     done: false,
//                         //     hour: time.hour,
//                         //     id: time.toString(),
//                         //     minute: time.minute,
//                         //     month: time.month,
//                         //     title: mainTitleText,
//                         //     weekDay: time.weekday,
//                         //     year: time.year,
//                         //   ),
//                         // );
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             duration: const Duration(milliseconds: 1500),
//                             behavior: SnackBarBehavior.fixed,
//                             content: Text('taskEditedSuccessfully'),
//                           ),
//                         );
//                         if (
//                             // imageString != ''
//                             true) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               duration: const Duration(milliseconds: 3500),
//                               behavior: SnackBarBehavior.fixed,
//                               content: Text(
//                                 'longPressTo',
//                               ),
//                             ),
//                           );
//                         }
//                       }

//                       Navigator.pop(context);
//                       //!send notif here ->
//                       AwesomeNotifications().createNotification(
//                         schedule: NotificationCalendar(
//                           day: time.day,
//                           hour: time.hour,
//                           minute: time.minute - 1,
//                           month: time.month,
//                           year: time.year,
//                         ),
//                         content: NotificationContent(
//                           category: NotificationCategory.Reminder,
//                           wakeUpScreen: true,
//                           color: Colors.orange,
//                           id: 10,
//                           channelKey: 'chanel',
//                           title: 'Daily Tasks', //add this to localization
//                           body:
//                               'time of $mainTitleText is now!', //add this to localization
//                         ),
//                       );
//                       //! -------------------
//                       // selectedCategory = '';
//                       // mainDescriptionText = '';
//                       // imageString = '';
//                       // mainTitleText = '';
//                       // _image = null;
//                       // pathOfVoice = '';
//                     }
//                   },