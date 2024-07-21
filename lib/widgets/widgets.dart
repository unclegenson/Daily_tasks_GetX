import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.titleText,
    required this.fontSize,
    required this.svgIcon,
  });
  final String titleText;
  final double fontSize;
  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Colors.black,
      ),
      titleSpacing: 10,
      leading: Builder(
        builder: (context) {
          return InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[800],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    svgIcon,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcATop,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      elevation: 0,
      toolbarHeight: 70,
      centerTitle: true,
      backgroundColor: Colors.black87,
      title: Text(
        titleText,
        style: TextStyle(
            fontSize: fontSize, fontFamily: 'title', color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
