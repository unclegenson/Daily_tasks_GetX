// import 'dart:io';
// import 'dart:ui';

// import 'package:audioplayers/audioplayers.dart';
// import 'package:daily_tasks_getx/controllers/done_task_controller.dart';
// import 'package:daily_tasks_getx/controllers/task_controller.dart';
// import 'package:daily_tasks_getx/widgets/widgets.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_sound/public/flutter_sound_player.dart' as h;
// import 'package:get/get.dart';

// final reviewAudioPlayer = AudioPlayer();
// String? reviewPathOfVoice;

// Duration reviewDurationOfAudio = Duration.zero;
// Duration reviewAudioPosition = Duration.zero;
// // @override
// // void initState() {
// //   reviewAudioPlayer.onPlayerStateChanged.listen(
// //     (event) {
// //       if (this.mounted) {
// //         setState(() {
// //           // ignore: unrelated_type_equality_checks
// //           isPlaying = event == h.PlayerState.isPlaying;
// //         });
// //       }
// //     },
// //   );
// //   reviewAudioPlayer.onDurationChanged.listen((newDuration) {
// //     if (this.mounted) {
// //       setState(() {
// //         reviewDurationOfAudio = newDuration;
// //       });
// //     }
// //   });
// //   reviewAudioPlayer.onPositionChanged.listen((newPosition) {
// //     if (this.mounted) {
// //       setState(() {
// //         reviewAudioPosition = newPosition;
// //       });
// //     }
// //   });
// //   reviewListCreate();
// //   super.initState();
// // }

// Future reviewSetAudio() async {
//   reviewAudioPlayer.setSourceDeviceFile(reviewPathOfVoice!);
// }

// class ReviewScreen extends StatelessWidget {
//   const ReviewScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black87,
//       appBar: AppBarWidget(
//         action: false,
//         back: true,
//         titleText: "Review Tasks".tr,
//         svgIcon: 'assets/back2.svg',
//         fontSize: 46,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             SizedBox(
//               height: Get.height - 122,
//               child: ListView.separated(
//                 separatorBuilder: (context, index) {
//                   return const SizedBox(
//                     height: 10,
//                   );
//                 },
//                 itemCount: Get.find<DoneTaskController>().doneTasks.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onLongPress: () {
//                       Get.find<DoneTaskController>().doneTasks[index].image !=
//                               null
//                           ? showGeneralDialog(
//                               barrierColor: Colors.black.withOpacity(0.5),
//                               transitionBuilder: (context, a1, a2, widget) {
//                                 return Transform.scale(
//                                   scale: a1.value,
//                                   child: Opacity(
//                                     opacity: a1.value,
//                                     child: AlertDialog(
//                                       backgroundColor: Colors.white24,
//                                       content: BackdropFilter(
//                                         filter: ImageFilter.blur(
//                                           sigmaX: 5,
//                                           sigmaY: 5,
//                                         ),
//                                         child: ClipRRect(
//                                           child: Container(
//                                             height: Get.width,
//                                             width: Get.width,
//                                             decoration: BoxDecoration(
//                                               // !-------------------image------------------
//                                               image: DecorationImage(
//                                                 fit: BoxFit.fitWidth,
//                                                 image: FileImage(
//                                                   File(
//                                                     Get.find<
//                                                             DoneTaskController>()
//                                                         .doneTasks[index]
//                                                         .image!,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                               transitionDuration:
//                                   const Duration(milliseconds: 200),
//                               barrierDismissible: true,
//                               barrierLabel: '',
//                               context: context,
//                               pageBuilder: (context, animation1, animation2) {
//                                 return Container();
//                               },
//                             )
//                           : const AboutDialog();
//                     },
//                     child: Stack(
//                       alignment: Alignment.bottomRight,
//                       children: [
//                         Container(
//                           height: 100,
//                           width: Get.width - 20,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             color: Color.fromARGB(
//                               Get.find<DoneTaskController>()
//                                   .doneTasks[index]
//                                   .colorAlpha!,
//                               Get.find<DoneTaskController>()
//                                   .doneTasks[index]
//                                   .colorRed!,
//                               Get.find<DoneTaskController>()
//                                   .doneTasks[index]
//                                   .colorGreen!,
//                               Get.find<DoneTaskController>()
//                                   .doneTasks[index]
//                                   .colorBlue!,
//                             ),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Get.find<DoneTaskController>()
//                                           .doneTasks[index]
//                                           .image !=
//                                       null
//                                   ? Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: ClipRRect(
//                                         child: Container(
//                                           height: 80,
//                                           width: 80,
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             // !-------------------image------------------
//                                             image: DecorationImage(
//                                               fit: BoxFit.cover,
//                                               image: FileImage(
//                                                 File(
//                                                   Get.find<DoneTaskController>()
//                                                       .doneTasks[index]
//                                                       .image!,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Container(
//                                         width: 80,
//                                         height: 80,
//                                         decoration: const BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: Colors.black,
//                                         ),
//                                         child: const Icon(
//                                           Icons.image_not_supported_rounded,
//                                           size: 45,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 12),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       Get.find<DoneTaskController>()
//                                           .doneTasks[index]
//                                           .title!,
//                                       style: const TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     Get.find<DoneTaskController>()
//                                                 .doneTasks[index]
//                                                 .description !=
//                                             ''
//                                         ? Text(
//                                             Get.find<DoneTaskController>()
//                                                 .doneTasks[index]
//                                                 .description!,
//                                             overflow: TextOverflow.ellipsis,
//                                             maxLines: 2,
//                                             style: const TextStyle(
//                                               color: Colors.black54,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                           )
//                                         : Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                               vertical: 6,
//                                             ),
//                                             child: SizedBox(
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   GestureDetector(
//                                                     onTap: () {
//                                                       // setState(() {
//                                                       //   reviewPathOfVoice =
//                                                       //       reviewVoiceList[
//                                                       //           index];
//                                                       // });
//                                                       reviewSetAudio();
//                                                       reviewAudioPlayer
//                                                           .resume();
//                                                     },
//                                                     child: Container(
//                                                       decoration:
//                                                           const BoxDecoration(
//                                                         shape: BoxShape.circle,
//                                                         color: Colors.black,
//                                                       ),
//                                                       width: 40,
//                                                       height: 40,
//                                                       child: const Icon(
//                                                         Icons.play_arrow,
//                                                         color: Colors.white,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   const SizedBox(
//                                                     width: 8,
//                                                   ),
//                                                   GestureDetector(
//                                                     onTap: () {
//                                                       reviewAudioPlayer.pause();
//                                                     },
//                                                     child: Container(
//                                                       decoration:
//                                                           const BoxDecoration(
//                                                         shape: BoxShape.circle,
//                                                         color: Colors.black,
//                                                       ),
//                                                       width: 40,
//                                                       height: 40,
//                                                       child: const Icon(
//                                                         Icons.pause,
//                                                         color: Colors.white,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 8, vertical: 4),
//                           child: Text(
//                             '${Get.find<DoneTaskController>().doneTasks[index].year.toString()} - ${Get.find<DoneTaskController>().doneTasks[index].month.toString()} - ${Get.find<DoneTaskController>().doneTasks[index].day.toString()}',
//                             softWrap: false,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               color: Colors.black38,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
