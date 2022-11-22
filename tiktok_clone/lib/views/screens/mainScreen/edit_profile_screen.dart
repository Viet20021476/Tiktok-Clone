import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/profile_controller.dart';
import 'package:tiktok_clone/views/screens/mainScreen/edit_content_screen.dart';
import 'package:tiktok_clone/views/widgets/option_row.dart';

class EditProfileScreen extends StatelessWidget {
  ProfileController controller;
  EditProfileScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: ListView(children: [
          SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 4,
                      color: Theme.of(context).scaffoldBackgroundColor),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0, 10))
                  ],
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Color.fromARGB(179, 146, 133, 133),
                          BlendMode.modulate),
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        controller.user['profilePhoto'],
                      ))),
              child: Icon(
                CupertinoIcons.camera,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              'Change avatar',
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Text(
                "About you",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Get.to(() => EditContentScreen(
                    title: 'Name',
                    controller: controller,
                  ));
            },
            child: OptionRow(
              title: "name",
              profileController: controller,
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => EditContentScreen(
                    title: 'TikTok ID',
                    controller: controller,
                  ));
            },
            child: OptionRow(
              title: "tiktokID",
              profileController: controller,
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => EditContentScreen(
                    title: 'Bio',
                    controller: controller,
                  ));
            },
            child: OptionRow(title: "bio", profileController: controller),
          ),
        ]),
      ),
    );
  }
}
