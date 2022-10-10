import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (() {
        firebaseAuth.signOut();
      })),
    );
  }
}
