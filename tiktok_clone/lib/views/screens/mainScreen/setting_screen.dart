import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/widgets/option_row.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

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
                  OptionRow(
                    title: "Change password",
                    data: '',
                  ),
                  OptionRow(
                    title: "Content settings",
                    data: '',
                  ),
                  OptionRow(
                    title: "Social",
                    data: '',
                  ),
                  OptionRow(
                    title: "Language",
                    data: '',
                  ),
                  OptionRow(
                    title: "Privacy and security",
                    data: '',
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
                  data: '',
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
