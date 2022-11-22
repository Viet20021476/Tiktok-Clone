import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tiktok_clone/controllers/upload_video_controller.dart';

class PostScreen extends StatefulWidget {
  String videoThumbnailUrl;
  String videoSongName;
  String videoPath;

  PostScreen(
      {super.key,
      required this.videoThumbnailUrl,
      required this.videoSongName,
      required this.videoPath});

  @override
  State<PostScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PostScreen> {
  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());
  TextEditingController captionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    captionController.dispose();
    Get.delete<UploadVideoController>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey.shade200,
              height: 1.0,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: (() {
              Navigator.pop(context, true);
            }),
          ),
          title: Text(
            'Post',
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(color: Colors.grey.shade200),
                bottom: BorderSide(color: Colors.grey.shade200),
              )),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: captionController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintMaxLines: 4,
                        hintText:
                            'Describe the post, add hashtags, and mention the creators who inspired you',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 110,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(color: Colors.black),
                    child: Image.file(File(widget.videoThumbnailUrl),
                        fit: BoxFit.cover),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 55,
              width: 150,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    uploadVideoController.uploadVideo(
                        widget.videoSongName,
                        captionController.text,
                        widget.videoPath,
                        widget.videoThumbnailUrl);
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Obx(() {
                            return uploadVideoController.isLoading
                                ? WillPopScope(
                                    onWillPop: () async {
                                      uploadVideoController.cancelUpload();
                                      return false;
                                    },
                                    child: Dialog(
                                      insetPadding: EdgeInsets.zero,
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      alignment: Alignment.center,
                                      child: Scaffold(
                                        extendBodyBehindAppBar: true,
                                        appBar: AppBar(
                                          leading: Container(),
                                          actions: [
                                            IconButton(
                                                onPressed: () {
                                                  uploadVideoController
                                                      .cancelUpload();
                                                },
                                                icon: Icon(Icons.close))
                                          ],
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                        ),
                                        backgroundColor: Colors.transparent,
                                        body: Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                child: Lottie.asset(
                                                  'assets/my-icons/tiktok_loader.json',
                                                  width: 120,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              uploadVideoController
                                                  .buildUploadStatus(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox();
                          });
                        });
                  },
                  icon: Icon(Icons.arrow_circle_up),
                  label: const Text(
                    "Post!",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}
