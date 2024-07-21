import 'package:daily_tasks_getx/screens/add_task.dart';
import 'package:daily_tasks_getx/screens/drawer_screen.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: true
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
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      },
                      childCount: 10,
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
                  ),
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
