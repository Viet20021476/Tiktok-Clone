import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/mainScreen/add_video_screen.dart';
import 'package:tiktok_clone/views/widgets/custom_icon.dart';
import 'package:tiktok_clone/views/widgets/tik_tok_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CustomIcon icon = CustomIcon();
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('my-home'),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          onTap: (idx) {
            setState(() {
              if (idx == 2) {
                Get.to(() => AddVideoScreen());
              } else {
                pageIdx = idx;
                icon.setPageId(pageIdx);
                icon.getPageId();
              }
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor:
              pageIdx == 4 || pageIdx == 3 ? backGroundColor : backGroundColor2,
          selectedItemColor:
              pageIdx == 4 || pageIdx == 3 ? backGroundColor2 : backGroundColor,
          unselectedItemColor: pageIdx == 4 || pageIdx == 3
              ? const Color.fromARGB(255, 114, 111, 111)
              : const Color.fromARGB(255, 255, 219, 219),
          currentIndex: pageIdx,
          items: [
            const BottomNavigationBarItem(

                icon: Icon(TikTokIcons.home, key: Key('video-button-bar'),), label: " Home"),
            const BottomNavigationBarItem(
                icon: Icon(
                  TikTokIcons.search,
                  key: Key('search-button-bar'),
                ),
                label: "Search"),
            BottomNavigationBarItem(icon: icon, label: ""),
            const BottomNavigationBarItem(
                icon: Icon(
                  TikTokIcons.messages,
                  key: Key('inbox-button-bar'),
                ),
                label: "Inbox"),
            const BottomNavigationBarItem(
                icon: Icon(
                  TikTokIcons.profile,
                  key: Key('profile-button-bar'),
                ),
                label: "Profile")
          ],
        ),
      ),
      body: pages[pageIdx],
    );
  }
}
