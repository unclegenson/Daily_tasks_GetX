import 'dart:io';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:daily_tasks_getx/controllers/done_task_controller.dart';
import 'package:daily_tasks_getx/controllers/image_controller.dart';
import 'package:daily_tasks_getx/controllers/task_controller.dart';
import 'package:daily_tasks_getx/controllers/text_field_controller.dart';
import 'package:daily_tasks_getx/controllers/user_info_controller.dart';
import 'package:daily_tasks_getx/models/general_models.dart';
import 'package:daily_tasks_getx/screens/add_task.dart';
import 'package:daily_tasks_getx/screens/drawer_screen.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import 'package:flutter_sound/public/flutter_sound_player.dart' as h;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeAudioPlayer.onPlayerStateChanged.listen(
      (event) {
        if (mounted) {
          setState(() {
            Get.find<TaskController>().isPlaying.value =
                // ignore: unrelated_type_equality_checks
                event == h.PlayerState.isPlaying;
          });
        }
      },
    );
    homeAudioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        Get.find<TaskController>().homeDurationOfAudio.value = newDuration;
      }
    });
    homeAudioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        Get.find<TaskController>().homeAudioPosition.value = newPosition;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const SizedBox(
        height: 65,
        width: 65,
        child: FAB(),
      ),
      drawer: const SafeArea(
        child: DrawerWidget(),
      ),
      backgroundColor: Colors.black87,
      appBar: AppBarWidget(
        action: false,
        back: false,
        titleText: "Daily Tasks".tr,
        svgIcon: 'assets/ham3.svg',
        fontSize: 46,
      ),
      body: const HomeBody(),
    );
  }
}

final homeAudioPlayer = AudioPlayer();

Future homeSetAudio() async {
  homeAudioPlayer
      .setSourceDeviceFile(Get.find<TaskController>().homePathOfVoice.value);
}

List colorItems = const [
  Color.fromARGB(255, 174, 213, 129),
  Color.fromARGB(255, 30, 136, 229),
  Color.fromARGB(255, 255, 138, 101),
  Color.fromARGB(255, 255, 193, 7),
  Color.fromARGB(255, 77, 182, 172),
  Color.fromARGB(255, 239, 83, 80),
  Color.fromARGB(255, 171, 71, 188),
  Color.fromARGB(255, 76, 175, 80),
];

List weekDays = [
  'Mon'.tr,
  'Tue'.tr,
  'Wed'.tr,
  'Tur'.tr,
  'Fri'.tr,
  'Sat'.tr,
  'Sun'.tr
];

bool done = false;

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Center(
        child: Get.find<TaskController>().tasks.isEmpty
            ? const EmptyHomeBodyWidget()
            : Padding(
                padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                child: CustomScrollView(
                  slivers: [
                    SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return GestureDetector(
                            onLongPress: () {
                              longPressEachTask(index, context);
                            },
                            onTap: () {
                              onTapEachTask(index);
                            },
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color.fromARGB(
                                        Get.find<TaskController>()
                                            .tasks[index]
                                            .colorAlpha!,
                                        Get.find<TaskController>()
                                            .tasks[index]
                                            .colorRed!,
                                        Get.find<TaskController>()
                                            .tasks[index]
                                            .colorGreen!,
                                        Get.find<TaskController>()
                                            .tasks[index]
                                            .colorBlue!,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Get.find<TaskController>()
                                                    .tasks[index]
                                                    .voice! ==
                                                ''
                                            ? Column(
                                                children: [
                                                  ShowTitleInTheTask(
                                                      index: index),
                                                  ShowDescriptionInTheTask(
                                                    index: index,
                                                  ),
                                                ],
                                              )
                                            : Stack(
                                                alignment: Alignment.topCenter,
                                                children: [
                                                  ShowTitleInMicTask(
                                                      index: index),
                                                  ShowAudioWidget(
                                                    index: index,
                                                  ),
                                                ],
                                              ),
                                        const Spacer(),
                                        DoneOrDeleteWidgets(index: index),
                                      ],
                                    ),
                                  ),
                                ),
                                Get.find<TaskController>().tasks[index].image !=
                                        ''
                                    ? ShowImageWidget(index: index)
                                    : const SizedBox(),
                                ShowDate(
                                  index: index,
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: Get.find<TaskController>().tasks.length,
                      ),
                      gridDelegate: SliverQuiltedGridDelegate(
                        crossAxisCount: 2,
                        mainAxisSpacing: 7,
                        crossAxisSpacing: 7,
                        repeatPattern: QuiltedGridRepeatPattern.inverted,
                        pattern: const [
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(1, 2),
                          QuiltedGridTile(2, 1),
                          QuiltedGridTile(1, 1),
                          QuiltedGridTile(1, 1),
                        ],
                      ),
                    )
                  ],
                ),
              ),
      );
    });
  }

  void onTapEachTask(int index) {
    Get.find<TaskController>().isEditing = true;
    Get.find<TaskController>().index = index;

    Get.find<TextFieldController>().taskTitle!.text =
        Get.find<TaskController>().tasks[index].title!;
    //
    Get.find<TextFieldController>().taskDesc!.text =
        Get.find<TaskController>().tasks[index].description!;
    Get.to(() => const AddTaskScreen());
  }

  void longPressEachTask(int index, BuildContext context) {
    Get.find<TaskController>().tasks[index].image != ''
        ? showGeneralDialog(
            barrierColor: Colors.black.withOpacity(0.5),
            transitionBuilder: (context, a1, a2, widget) {
              return Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    backgroundColor: Colors.white24,
                    content: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5,
                      ),
                      child: ClipRRect(
                        child: Container(
                          height: Get.width,
                          width: Get.width,
                          decoration: BoxDecoration(
                            // !-------------------image------------------
                            image: DecorationImage(
                              image: FileImage(
                                File(
                                  Get.find<TaskController>()
                                      .tasks[index]
                                      .image!,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 200),
            barrierDismissible: true,
            barrierLabel: '',
            context: context,
            pageBuilder: (context, animation1, animation2) {
              return Container();
            },
          )
        : const AboutDialog();
  }
}

class ShowDate extends StatelessWidget {
  const ShowDate({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    weekDays = [
      'Mon'.tr,
      'Tue'.tr,
      'Wed'.tr,
      'Tur'.tr,
      'Fri'.tr,
      'Sat'.tr,
      'Sun'.tr
    ];
    return Align(
      alignment: Get.find<UserInfoController>().language.value == 'en'
          ? Alignment.bottomRight
          : Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          '${weekDays[Get.find<TaskController>().tasks[index].weekDay! - 1]} - ${Get.find<TaskController>().tasks[index].day!.toString()}',
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black38,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class ShowImageWidget extends StatelessWidget {
  const ShowImageWidget({
    super.key,
    required this.index,
  });

  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: SizedBox(
        height: 36,
        width: 36,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            File(Get.find<TaskController>().tasks[index].image!),
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class DoneOrDeleteWidgets extends StatelessWidget {
  const DoneOrDeleteWidgets({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            children: [
              SizedBox(
                width: Get.width / 10,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                  ),
                  onPressed: () {
                    PanaraConfirmDialog.showAnimatedGrow(
                      context,
                      title: 'done?'.tr,
                      message: "Press Yes if you'he done this task.".tr,
                      confirmButtonText: 'Yes'.tr,
                      cancelButtonText: 'No'.tr,
                      onTapCancel: () {
                        Navigator.pop(context);
                      },
                      onTapConfirm: () {
                        Get.find<TaskController>().tasks[index].done = true;
                        Get.find<DoneTaskController>().doneTasks.add(
                              TasksModel(
                                audioId:
                                    Get.find<TaskController>().audioId.value,
                                category: Get.find<TaskController>()
                                    .tasks[index]
                                    .category,
                                colorAlpha: Get.find<TaskController>()
                                    .tasks[index]
                                    .colorAlpha,
                                day:
                                    Get.find<TaskController>().tasks[index].day,
                                description: Get.find<TaskController>()
                                    .tasks[index]
                                    .description,
                                done: Get.find<TaskController>()
                                    .tasks[index]
                                    .done,
                                hour: Get.find<TaskController>()
                                    .tasks[index]
                                    .hour,
                                minute: Get.find<TaskController>()
                                    .tasks[index]
                                    .minute,
                                month: Get.find<TaskController>()
                                    .tasks[index]
                                    .month,
                                title: Get.find<TaskController>()
                                    .tasks[index]
                                    .title,
                                weekDay: Get.find<TaskController>()
                                    .tasks[index]
                                    .weekDay,
                                year: Get.find<TaskController>()
                                    .tasks[index]
                                    .year,
                                colorRed: Get.find<TaskController>()
                                    .tasks[index]
                                    .colorRed,
                                colorBlue: Get.find<TaskController>()
                                    .tasks[index]
                                    .colorBlue,
                                colorGreen: Get.find<TaskController>()
                                    .tasks[index]
                                    .colorGreen,
                                image: Get.find<TaskController>()
                                    .tasks[index]
                                    .image,
                                voice: Get.find<TaskController>()
                                    .tasks[index]
                                    .voice,
                              ),
                            );
                        Get.find<TaskController>().tasks.removeAt(index);

                        Get.back();
                      },
                      panaraDialogType: PanaraDialogType.warning,
                      noImage: true,
                    );
                  },
                  child: const Icon(
                    Icons.check,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width / 10,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                          ),
                        ),
                        onPressed: () {
                          PanaraConfirmDialog.showAnimatedGrow(
                            context,
                            title: 'Delete This Task'.tr,
                            message:
                                'Are you sure you want to delete this Task?'.tr,
                            confirmButtonText: 'Yes'.tr,
                            cancelButtonText: 'No'.tr,
                            onTapCancel: () {
                              Navigator.pop(context);
                            },
                            onTapConfirm: () {
                              Get.find<TaskController>().tasks.removeAt(index);
                              Get.back();
                            },
                            panaraDialogType: PanaraDialogType.warning,
                            noImage: true,
                          );
                        },
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ShowAudioWidget extends StatelessWidget {
  const ShowAudioWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Get.find<TaskController>().homePathOfVoice.value ==
                  Get.find<TaskController>().tasks[index].voice!
              ? Slider(
                  activeColor: Colors.green,
                  divisions: 20,
                  value: Get.find<TaskController>()
                      .homeAudioPosition
                      .value
                      .inSeconds
                      .toDouble(),
                  onChanged: (value) async {
                    final homeAudioPosition = Duration(seconds: value.toInt());
                    await homeAudioPlayer.seek(
                      homeAudioPosition,
                    );
                  },
                  min: 0,
                  max: Get.find<TaskController>()
                      .homeDurationOfAudio
                      .value
                      .inSeconds
                      .toDouble(),
                )
              : Slider(
                  activeColor: Colors.grey[600],
                  divisions: 20,
                  value: 0,
                  onChanged: (value) {},
                  min: 0,
                  max: 100,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.find<TaskController>().homePathOfVoice.value =
                      Get.find<TaskController>().tasks[index].voice!;

                  homeSetAudio();
                  homeAudioPlayer.resume();
                },
                child: Container(
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
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  homeAudioPlayer.pause();
                },
                child: Container(
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
              ),
            ],
          ),
        ],
      );
    });
  }
}

class ShowTitleInMicTask extends StatelessWidget {
  const ShowTitleInMicTask({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        Get.find<TaskController>()
            .tasks[index]
            .title!, //!--------------------TEXT-----------------------
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}

class ShowDescriptionInTheTask extends StatelessWidget {
  const ShowDescriptionInTheTask({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          Get.find<TaskController>()
              .tasks[index]
              .description!, //@------------------------DESCRIPTION-------------------
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      ),
    );
  }
}

class ShowTitleInTheTask extends StatelessWidget {
  const ShowTitleInTheTask({
    super.key,
    required this.index,
  });

  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 12,
        right: 10,
        top: 10,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          Get.find<TaskController>()
              .tasks[index]
              .title!, //!--------------------TITLE-----------------------
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}

class EmptyHomeBodyWidget extends StatelessWidget {
  const EmptyHomeBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/ast.svg',
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcATop),
        ),
        Text(
          'Add New Task!'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 45,
            fontFamily: Get.find<UserInfoController>().language.value == 'en'
                ? 'title'
                : 'farsi',
          ),
        )
      ],
    );
  }
}

class FAB extends StatelessWidget {
  const FAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () {
        Get.find<ImageController>().imagePath.value = '';
        Get.find<TaskController>().isEditing = false;
        Get.find<TaskController>().category.value = '';
        Get.find<TaskController>().colorAlpha.value = 0;
        Get.find<TaskController>().colorBlue.value = 0;
        Get.find<TaskController>().colorGreen.value = 0;
        Get.find<TaskController>().colorRed.value = 0;
        Get.find<TaskController>().day.value = 0;
        Get.find<TaskController>().hour.value = 0;
        Get.find<TaskController>().minute.value = 0;
        Get.find<TaskController>().month.value = 0;
        Get.find<TaskController>().year.value = 0;
        Get.find<TaskController>().weekDay.value = 0;
        Get.find<TaskController>().image.value = '';
        Get.find<TaskController>().index =
            Get.find<TaskController>().tasks.length + 1;
        Get.find<TextFieldController>().taskTitle!.text = '';
        Get.find<TextFieldController>().taskDesc!.text = '';

        Get.to(() => const AddTaskScreen());
      },
      backgroundColor: Colors.grey[800],
      child: const SizedBox(
        height: 35,
        width: 35,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
