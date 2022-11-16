import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/upload_video_controller.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const ConfirmScreen(
      {Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  TextEditingController songController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.addListener(() {
      setState(() {});
    });
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
    controller.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
          onTap: () {
            Get.back();
          },
        ),
        title: const Text(
          'Edit your video!!!',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 30.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (() {})),
      // const SizedBox(
      //   height: 30,
      // ),
      // SingleChildScrollView(
      //   scrollDirection: Axis.vertical,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       Container(
      //         margin: const EdgeInsets.symmetric(horizontal: 10),
      //         width: MediaQuery.of(context).size.width - 20,
      //         child: TextInputField(
      //           controller: songController,
      //           labelText: "Song Name",
      //           icon: Icons.music_note,
      //           isObscure: false,
      //         ),
      //       ),
      //       const SizedBox(height: 10),
      //       Container(
      //         margin: const EdgeInsets.symmetric(horizontal: 10),
      //         width: MediaQuery.of(context).size.width - 20,
      //         child: TextInputField(
      //           controller: captionController,
      //           labelText: "Caption",
      //           icon: Icons.closed_caption,
      //           isObscure: false,
      //         ),
      //       ),
      //       const SizedBox(height: 10),
      //       ElevatedButton(
      //           onPressed: () => uploadVideoController.uploadVideo(
      //               songController.text,
      //               captionController.text,
      //               widget.videoPath),
      //           child: const Text(
      //             "Share!",
      //             style: TextStyle(fontSize: 20, color: Colors.white),
      //           ))
      //     ],
      //   ),
      // )
    );
  }
}
