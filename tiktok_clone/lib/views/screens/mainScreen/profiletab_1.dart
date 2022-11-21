import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/profile_controller.dart';
import 'package:tiktok_clone/views/screens/mainScreen/video_screen.dart';

class FirstTab extends StatelessWidget {
  ProfileController controller;
  FirstTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: controller.user['thumbnails'].length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 2 / 3),
        itemBuilder: (context, index) {
          String thumbnail = controller.user['thumbnails'][index];
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: InkWell(
              onTap: () {
                Get.to(() =>
                    new VideoScreen(uid: controller.uid, thumbnail: index));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        image: NetworkImage(thumbnail), fit: BoxFit.contain)),
              ),
            ),
          );
        });
  }
}
