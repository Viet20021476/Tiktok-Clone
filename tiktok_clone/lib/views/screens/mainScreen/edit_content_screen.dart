import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/profile_controller.dart';

class EditContentScreen extends StatefulWidget {
  EditContentScreen({super.key, required this.title, required this.controller});
  String title;
  ProfileController controller;

  @override
  State<EditContentScreen> createState() => _EditContentScreenState();
}

class _EditContentScreenState extends State<EditContentScreen> {
  final TextEditingController fieldController = TextEditingController();
  String currentDocument = '';

  @override
  Widget build(BuildContext context) {
    Rx<String> currentText;
    switch (widget.title) {
      case 'Name':
        fieldController.text = widget.controller.user['name'];
        currentText = fieldController.text.obs;
        currentDocument = 'name';
        break;
      case 'TikTok ID':
        fieldController.text = widget.controller.user['tiktokID'];
        currentDocument = 'tiktokID';
        currentText = fieldController.text.obs;
        break;
      case 'Bio':
        currentDocument = 'bio';
        fieldController.text = widget.controller.user['bio'];
        currentText = fieldController.text.obs;
        break;
      default:
        currentText = fieldController.text.obs;
    }

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            widget.title,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                widget.controller
                    .updateContent(fieldController.text, currentDocument);
                widget.controller.getUserData();
              },
              child: Text(
                "Save",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            )
          ],
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                color: Color.fromARGB(255, 202, 200, 200),
                height: 1.0,
              )),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Center(
              child: Text(
                "Cancel",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(14),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            TextFormField(
              maxLines: widget.title == 'Bio' ? 5 : 1,
              onChanged: (value) {
                currentText.value = fieldController.text;
              },
              controller: fieldController,
              inputFormatters: [
                widget.title == 'Bio'
                    ? LengthLimitingTextInputFormatter(80)
                    : LengthLimitingTextInputFormatter(30),
              ],
              decoration: InputDecoration(
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Text(
                  currentText.value.length.toString(),
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  widget.title == 'Bio' ? '/80' : '/30',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            )
          ]),
        ),
      );
    });
  }
}
