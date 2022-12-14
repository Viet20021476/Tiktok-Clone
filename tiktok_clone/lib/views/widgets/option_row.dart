import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/profile_controller.dart';

// ignore: must_be_immutable
class OptionRow extends StatelessWidget {
  String title;
  ProfileController profileController;

  OptionRow({super.key, required this.title, required this.profileController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1 / 3,
                    child: Text(
                      profileController.user[title] != null
                          ? profileController.user[title]
                          : '',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 14,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
