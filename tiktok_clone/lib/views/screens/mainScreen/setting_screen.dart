import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/profile_controller.dart';
import 'package:tiktok_clone/views/screens/authens/change_password_sceen.dart';
import 'package:tiktok_clone/views/widgets/option_row.dart';

// ignore: must_be_immutable
class SettingScreen extends StatefulWidget {
  SettingScreen({super.key, required this.controller});
  ProfileController controller;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 244, 244),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          key: Key('setting-back'),
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
        padding: EdgeInsets.only(left: 8, right: 8),
        child: ListView(
          children: [
            Text(
              "Settings",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
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
                  "Account",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: Colors.white),
              child: Column(
                children: [
                  InkWell(
                    key: Key('change-pass-btn'),
                    onTap: () {
                      Get.to(() => ChangePasswordScreen());
                    },
                    child: OptionRow(
                      title: "Change password",
                      profileController: widget.controller,
                    ),
                  ),
                  OptionRow(
                    title: "Content settings",
                    profileController: widget.controller,
                  ),
                  OptionRow(
                    title: "Social",
                    profileController: widget.controller,
                  ),
                  OptionRow(
                    title: "Language",
                    profileController: widget.controller,
                  ),
                  OptionRow(
                    title: "Privacy and security",
                    profileController: widget.controller,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 15,
              thickness: 1,
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
                  "Log out",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: InkWell(
                child: OptionRow(
                  title: "Log out",
                  profileController: widget.controller,
                ),
                onTap: () {
                  authController.signOutUser();
                },
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6), color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
