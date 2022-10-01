import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/widgets/custom_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx) {
          setState(() {
            pageIdx = idx;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: backGroundColor2,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        currentIndex: pageIdx,
        items: const [
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
          BottomNavigationBarItem(icon: CustomIcon(), label: ""),
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
