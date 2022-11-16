import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/widgets/custom_icon.dart';
import 'package:tiktok_clone/views/widgets/tik_tok_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CustomIcon icon = const CustomIcon();
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
              pageIdx = idx;
              icon.setPageId(pageIdx);
              icon.getPageId();
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
                icon: Icon(TikTokIcons.home), label: " Home"),
            const BottomNavigationBarItem(
                icon: Icon(TikTokIcons.search), label: "Search"),
            BottomNavigationBarItem(icon: icon, label: ""),
            const BottomNavigationBarItem(
                icon: Icon(TikTokIcons.messages), label: "Inbox"),
            const BottomNavigationBarItem(
                icon: Icon(TikTokIcons.profile), label: "Profile")
          ],
        ),
      ),
      body: pages[pageIdx],
    );
  }
}
