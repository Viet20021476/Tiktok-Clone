import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/widgets/custom_icon.dart';

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
      bottomNavigationBar: BottomNavigationBar(
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
            ? Color.fromARGB(255, 114, 111, 111)
            : Color.fromARGB(255, 255, 219, 219),
        currentIndex: pageIdx,
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/my-icons/homesolidicon.png'),
                size: 30,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/my-icons/searchicon.png'),
                size: 30,
              ),
              label: "Search"),
          BottomNavigationBarItem(icon: icon, label: ""),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/my-icons/messagestrokeicon.png'),
                size: 30,
              ),
              label: "Inbox"),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/my-icons/accountstrokeicon.png'),
                size: 30,
              ),
              label: "Profile")
        ],
      ),
      body: pages[pageIdx],
    );
  }
}
