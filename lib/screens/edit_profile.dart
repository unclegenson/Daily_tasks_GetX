import 'dart:io';
import 'package:daily_tasks_getx/screens/home.dart';
import 'package:daily_tasks_getx/screens/settings_screen.dart';
import 'package:daily_tasks_getx/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

String imageController = '';
String nameController = '';
String numberController = '';
bool checkFirstEntry = true;
checkEnterForFirstTime() async {
  SharedPreferences isActivePref = await SharedPreferences.getInstance();
  if (isActivePref.getBool('isActive') == null) {
    setProfileData();
    SharedPreferences premium = await SharedPreferences.getInstance();
    premium.setBool('purchase', false);
    // scheduleDailyNotification();
  } else {
    checkFirstEntry = false;
    loadProfileData();
  }
}

loadProfileData() async {
  SharedPreferences prefProfileImage = await SharedPreferences.getInstance();
  SharedPreferences prefProfileName = await SharedPreferences.getInstance();
  SharedPreferences prefProfileNumber = await SharedPreferences.getInstance();

  // setState(() {
  //   nameController = prefProfileName.getString('profileName')!;
  //   numberController = prefProfileNumber.getString('profileNumber')!;
  //   imageController = prefProfileImage.getString('profileImage')!;
  // });
}

setProfileData() async {
  SharedPreferences isActivePref = await SharedPreferences.getInstance();
  SharedPreferences prefProfileImage = await SharedPreferences.getInstance();
  SharedPreferences prefProfileName = await SharedPreferences.getInstance();
  SharedPreferences prefProfileNumber = await SharedPreferences.getInstance();

  await isActivePref.setBool('isActive', true);
  await prefProfileNumber.setString('profileNumber', numberController);
  await prefProfileName.setString('profileName', nameController);
  await prefProfileImage.setString('profileImage', imageController);
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
            backgroundColor: Colors.indigo[400],
          ),
          child: const Text(
            'Photo Gallery',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            // close the options modal
            Get.back();
            // get image from gallery
            getImageFromGallery();
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
            backgroundColor: Colors.indigo[400],
          ),
          child: const Text(
            'Camera',
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

final picker = ImagePicker();

//Image Picker function to get image from gallery
Future getImageFromGallery() async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  // setState(() {
  //   if (pickedFile != null) {
  //     // setState(() {
  //     //   imageController = pickedFile.path;
  //     // });
  //   }
  // });
}

//Image Picker function to get image from camera
Future getImageFromCamera() async {
  final pickedFile = await picker.pickImage(source: ImageSource.camera);

  // setState(() {
  //   if (pickedFile != null) {
  //     // setState(() {
  //     //   imageController = pickedFile.path;
  //     // });
  //   }
  // });
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBarWidget(
        action: false,
        back: true,
        titleText: "Edit Profile",
        svgIcon: 'assets/back2.svg',
        fontSize: 46,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    imageController == ''
                        ? CircleAvatar(
                            backgroundColor: Colors.indigo[400],
                            radius: Get.width / 2 - 30,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: Get.width / 2,
                            ),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.indigo[400],
                            backgroundImage: FileImage(File(imageController)),
                            radius: Get.width / 2 - 30,
                          ),
                    GestureDetector(
                      onTap: showOptions,
                      child: Padding(
                        padding: EdgeInsets.all(Get.width / 20),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black54,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.edit,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SettingsCategoryWidget(
                text: 'Name :',
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  initialValue: nameController,
                  onChanged: (value) {
                    // setState(
                    //   () {
                    //     nameController = value;
                    //   },
                    // );
                  },
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SettingsCategoryWidget(
                color: Colors.white,
                text: 'Number :',
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  inputFormatters: [LengthLimitingTextInputFormatter(11)],
                  decoration: const InputDecoration(
                    hintText: '09100000000',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  initialValue: numberController,
                  onChanged: (value) {
                    // setState(() {
                    //   if (value.length > 10) {
                    //     String val1 = value.substring(1, 4);
                    //     String val2 = value.substring(4, 7);
                    //     String val3 = value.substring(7);

                    //     numberController = '$val1 $val2 $val3';
                    //   }
                    // });
                  },
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: Get.height / 10,
              ),
              SizedBox(
                width: Get.width - 40,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (nameController == '' || numberController == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              '''You must add your profile data to use the app
Your profile data will be unreachable for others.'''),
                        ),
                      );
                    } else {
                      setProfileData();
                      if (checkFirstEntry) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const Home();
                            },
                          ),
                        );
                      }

                      Get.back();
                    }
                  },
                  child: const Text(
                    'Done',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
