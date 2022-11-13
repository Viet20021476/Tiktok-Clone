import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/profile_controller.dart';

class FirstTab extends StatelessWidget {
  ProfileController controller;
  FirstTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: controller.user['thumbnails'].length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          String thumbnail = controller.user['thumbnails'][index];
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              //height: 70,
              //width: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(thumbnail), fit: BoxFit.fill)),
            ),
          );
        });
  }
}
