import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomIcon extends StatelessWidget {
  RxInt pageId = 0.obs;
  CustomIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
          width: 45,
          height: 30,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: 38,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 45, 108),
                    borderRadius: BorderRadius.circular(7)),
              ),
              Container(
                margin: const EdgeInsets.only(right: 10),
                width: 38,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 32, 211, 234),
                    borderRadius: BorderRadius.circular(7)),
              ),
              Center(
                child: Container(
                  height: double.infinity,
                  width: 38,
                  decoration: BoxDecoration(
                      color: pageId == 4 || pageId == 3
                          ? Colors.black
                          : Colors.white,
                      borderRadius: BorderRadius.circular(7)),
                  child: Icon(
                    Icons.add,
                    color: pageId.value == 4 || pageId == 3
                        ? Colors.white
                        : Colors.black,
                    size: 20,
                  ),
                ),
              )
            ],
          ));
    });
  }

  void setPageId(int id) {
    pageId.value = id;
  }

  int getPageId() {
    return pageId.value;
  }
}
