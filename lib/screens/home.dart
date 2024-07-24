import 'dart:io';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:daily_tasks_getx/controllers/task_controllers.dart';
import 'package:daily_tasks_getx/controllers/text_field_controller.dart';
import 'package:daily_tasks_getx/models/hive_models.dart';
import 'package:daily_tasks_getx/screens/add_task.dart';
import 'package:daily_tasks_getx/screens/drawer_screen.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FAB(),
      ),
      drawer: SafeArea(
        child: DrawerWidget(),
      ),
      backgroundColor: Colors.black87,
      appBar: AppBarWidget(
        action: false,
        back: false,
        titleText: "Daily Tasks",
        svgIcon: 'assets/ham3.svg',
        fontSize: 46,
      ),
      body: HomeBody(),
    );
  }
}

String? homePathOfVoice;

Duration homeDurationOfAudio = Duration.zero;
Duration homeAudioPosition = Duration.zero;
final homeAudioPlayer = AudioPlayer();

List colorItems = const [
  Color.fromARGB(255, 137, 207, 240),
  Color.fromARGB(255, 255, 229, 180),
  Color.fromARGB(255, 255, 209, 220),
  Color.fromARGB(255, 169, 211, 158),
  Color.fromARGB(255, 255, 200, 152),
  Color.fromARGB(255, 195, 177, 225),
  Color.fromARGB(255, 193, 187, 221),
  Color.fromARGB(255, 218, 191, 222),
  Color.fromARGB(255, 255, 220, 244),
  Color.fromARGB(255, 220, 255, 251),
  Color.fromARGB(255, 193, 231, 227),
];
List voiceList = [];

List weekDays = ['Mon', 'Tue', 'Wed', 'Tur', 'Fri', 'Sat', 'Sun'];
List titles = [];

List descriptions = [];

List dateTimes = [];

List containerColors = [];

List categories = [];

bool done = false;

List boxImages = [];

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Get.find<TaskController>().tasks.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/ast.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcATop),
                ),
                const Text(
                  'Add New Task!',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                )
              ],
            )
          : Padding(
              padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
              child: CustomScrollView(
                slivers: [
                  Obx(() {
                    return SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return GestureDetector(
                            onLongPress: () {
                              boxImages[index] != null
                                  ? showGeneralDialog(
                                      barrierColor:
                                          Colors.black.withOpacity(0.5),
                                      transitionBuilder:
                                          (context, a1, a2, widget) {
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
                                                            boxImages[index],
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
                                      transitionDuration:
                                          const Duration(milliseconds: 200),
                                      barrierDismissible: true,
                                      barrierLabel: '',
                                      context: context,
                                      pageBuilder:
                                          (context, animation1, animation2) {
                                        return Container();
                                      },
                                    )
                                  : const AboutDialog();
                            },
                            onTap: () {
                              Get.find<TaskController>().isEditing.value = true;
                              Get.find<TaskController>().index = index;

                              Get.find<TextFieldController>().taskTitle!.text =
                                  Get.find<TaskController>()
                                      .tasks[index]
                                      .title!;
                              //
                              Get.find<TextFieldController>().taskDesc!.text =
                                  Get.find<TaskController>()
                                      .tasks[index]
                                      .description!;
                              Get.to(() => AddTaskScreen());
                            },
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
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
                                              .colorBlue!),
                                      //? -----------------------COLOR----------------------------
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Get.find<TaskController>()
                                                    .tasks[index]
                                                    .title! ==
                                                ''
                                            ? Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 12,
                                                      right: 10,
                                                      top: 10,
                                                    ),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        Get.find<
                                                                TaskController>()
                                                            .tasks[index]
                                                            .title!, //!--------------------TITLE-----------------------
                                                        style: const TextStyle(
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12,
                                                            right: 10),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        Get.find<
                                                                TaskController>()
                                                            .tasks[index]
                                                            .description!, //@------------------------DESCRIPTION-------------------
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black54,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 3,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Stack(
                                                alignment: Alignment.topCenter,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      Get.find<TaskController>()
                                                          .tasks[index]
                                                          .title!, //!--------------------TEXT-----------------------
                                                      style: const TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 30,
                                                      ),
                                                      homePathOfVoice ==
                                                              Get.find<
                                                                      TaskController>()
                                                                  .tasks[index]
                                                                  .voice!
                                                          ? Slider(
                                                              activeColor:
                                                                  Colors.green,
                                                              divisions: 20,
                                                              value:
                                                                  homeAudioPosition
                                                                      .inSeconds
                                                                      .toDouble(),
                                                              onChanged:
                                                                  (value) async {
                                                                final homeAudioPosition =
                                                                    Duration(
                                                                        seconds:
                                                                            value.toInt());
                                                                await homeAudioPlayer
                                                                    .seek(
                                                                  homeAudioPosition,
                                                                );
                                                              },
                                                              min: 0,
                                                              max: homeDurationOfAudio
                                                                  .inSeconds
                                                                  .toDouble(),
                                                            )
                                                          : Slider(
                                                              activeColor:
                                                                  Colors.green,
                                                              divisions: 20,
                                                              value: 0,
                                                              onChanged:
                                                                  (value) {},
                                                              min: 0,
                                                              max: 100,
                                                            ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              // setState(() {
                                                              //   homePathOfVoice =
                                                              //       voiceList[
                                                              //           index];
                                                              // });
                                                              // homeSetAudio();
                                                              // homeAudioPlayer
                                                              //     .resume();
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              width: 40,
                                                              height: 40,
                                                              child: const Icon(
                                                                Icons
                                                                    .play_arrow,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // homeAudioPlayer
                                                              //     .pause();
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              width: 40,
                                                              height: 40,
                                                              child: const Icon(
                                                                Icons.pause,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                        const Spacer(),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: Get.width / 10,
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        backgroundColor:
                                                            Colors.green,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            16,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        // setState(() {
                                                        //   done = true;
                                                        // });
                                                        PanaraConfirmDialog
                                                            .showAnimatedGrow(
                                                          context,
                                                          title: 'done2',
                                                          message: 'pressYesIf',
                                                          confirmButtonText:
                                                              'yes',
                                                          cancelButtonText:
                                                              'no',
                                                          onTapCancel: () {
                                                            Navigator.pop(
                                                                context);
                                                            // setState(() {
                                                            //   done = false;
                                                            // });
                                                          },
                                                          onTapConfirm: () {
                                                            // Hive.box<Notes>(
                                                            //         'notesBox')
                                                            //     .putAt(
                                                            //   index,
                                                            //   Notes(
                                                            //     voice:
                                                            //         voiceList[
                                                            //             index],
                                                            //     image:
                                                            //         boxImages[
                                                            //             index],
                                                            //     id: index
                                                            //         .toString(),
                                                            //     title: titles[
                                                            //         index],
                                                            //     category:
                                                            //         categories[
                                                            //             index],
                                                            //     description:
                                                            //         descriptions[
                                                            //             index],
                                                            //     done: true,
                                                            //     colorAlpha:
                                                            //         containerColors[
                                                            //                 index]
                                                            //             .alpha,
                                                            //     colorBlue:
                                                            //         containerColors[
                                                            //                 index]
                                                            //             .blue,
                                                            //     colorGreen:
                                                            //         containerColors[
                                                            //                 index]
                                                            //             .green,
                                                            //     colorRed:
                                                            //         containerColors[
                                                            //                 index]
                                                            //             .red,
                                                            //     day: dateTimes[
                                                            //             index]
                                                            //         ['day'],
                                                            //     hour: dateTimes[
                                                            //             index]
                                                            //         ['hour'],
                                                            //     minute: dateTimes[
                                                            //             index]
                                                            //         [
                                                            //         'minute'],
                                                            //     month: dateTimes[
                                                            //             index]
                                                            //         ['mount'],
                                                            //     weekDay: dateTimes[
                                                            //             index]
                                                            //         [
                                                            //         'weekDay'],
                                                            //     year: dateTimes[
                                                            //             index]
                                                            //         ['year'],
                                                            //   ),
                                                            // );
                                                            // textsListCreate();

                                                            // setState(() {
                                                            //   done = false;
                                                            // });
                                                            Get.back();
                                                          },
                                                          panaraDialogType:
                                                              PanaraDialogType
                                                                  .warning,
                                                          noImage: true,
                                                        );
                                                      },
                                                      child: done
                                                          ? SizedBox(
                                                              width: 20,
                                                              height: 20,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: colorItems[
                                                                    index %
                                                                        colorItems
                                                                            .length],
                                                                strokeWidth: 1,
                                                              ),
                                                            )
                                                          : const Icon(
                                                              Icons.check,
                                                              size: 20,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: Get.width / 10,
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              backgroundColor:
                                                                  Colors.red,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  16,
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              // setState(() {
                                                              //   done = true;
                                                              // });
                                                              PanaraConfirmDialog
                                                                  .showAnimatedGrow(
                                                                context,
                                                                title:
                                                                    'deleteThisTask',
                                                                message:
                                                                    'areYouSureDelete',
                                                                confirmButtonText:
                                                                    'yes',
                                                                cancelButtonText:
                                                                    'no',
                                                                onTapCancel:
                                                                    () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  // setState(
                                                                  //     () {
                                                                  //   done =
                                                                  //       false;
                                                                  // });
                                                                },
                                                                onTapConfirm:
                                                                    () {
                                                                  Get.find<
                                                                          TaskController>()
                                                                      .tasks
                                                                      .removeAt(
                                                                          index);
                                                                  // Hive.box<Notes>(
                                                                  //         'notesBox')
                                                                  //     .deleteAt(
                                                                  //         index);
                                                                  // textsListCreate();
                                                                  // setState(
                                                                  //     () {
                                                                  //   done =
                                                                  //       false;
                                                                  // });
                                                                  Get.back();
                                                                },
                                                                panaraDialogType:
                                                                    PanaraDialogType
                                                                        .warning,
                                                                noImage: true,
                                                              );
                                                            },
                                                            child: done
                                                                ? SizedBox(
                                                                    width: 20,
                                                                    height: 20,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color: colorItems[
                                                                          index %
                                                                              colorItems.length],
                                                                      strokeWidth:
                                                                          1,
                                                                    ),
                                                                  )
                                                                : const Icon(
                                                                    Icons.close,
                                                                    size: 20,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
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
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Get.find<TaskController>().tasks[index].image !=
                                        null
                                    ? Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(
                                              File(Get.find<TaskController>()
                                                  .tasks[index]
                                                  .image!),
                                              filterQuality: FilterQuality.high,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
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
                    );
                  })
                ],
              ),
            ),
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
        Get.find<TaskController>().isEditing.value = false;

        Get.find<TextFieldController>().taskTitle!.text = '';
        Get.find<TextFieldController>().taskDesc!.text = '';

        Get.to(() => AddTaskScreen());
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
