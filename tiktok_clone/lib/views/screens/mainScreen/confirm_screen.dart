import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:tiktok_clone/controllers/upload_video_controller.dart';
import 'package:tiktok_clone/views/screens/mainScreen/post_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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
  var videoThumbnailUrl;
  TextEditingController songController = TextEditingController();
  String songName = '';
  bool isSongNameSelected = false;

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
    controller.dispose();
    songController.dispose();
    super.dispose();
    print('dispose');
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
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 68, 63, 63).withOpacity(0.3),
          ),
          width: MediaQuery.of(context).size.width * 0.6,
          height: 40,
          child: InkWell(
            onTap: () async {
              final songName = await openDialog();
              if (songName == null || songName.isEmpty) {
                setState(() {});
              } else {
                setState(() {
                  isSongNameSelected = true;
                  this.songName = songName;
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.music_note_rounded),
                isSongNameSelected
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Marquee(
                            text: '${songName}    •   ',
                            velocity: 8,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                      )
                    : Text(
                        'Add song name',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                isSongNameSelected
                    ? InkWell(
                        child: Icon(Icons.close),
                        onTap: (() {
                          setState(() {
                            isSongNameSelected = false;
                          });
                        }),
                      )
                    : SizedBox(),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
        ],
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                extendedSizeConstraints:
                    BoxConstraints.tightFor(width: 120, height: 50))),
        child: FloatingActionButton.extended(
          onPressed: (() async {
            controller.pause();
            videoThumbnailUrl = await VideoThumbnail.thumbnailFile(
              video: widget.videoPath, imageFormat: ImageFormat.PNG,
              maxWidth: 0,
              // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
            );
            final checkData = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostScreen(
                          videoThumbnailUrl: videoThumbnailUrl,
                          videoSongName: songName,
                          videoPath: widget.videoPath,
                        )));
            setState(() {
              print(checkData);
              if (checkData != null) {
                controller.play();
              } else {
                controller.play();
              }
            });
          }),
          label: Text(
            'Next',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }

  Future<String?> openDialog() => showDialog<String>(
      context: context,
      builder: (builder) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: IntrinsicWidth(
            child: TextField(
              controller: songController,
              maxLines: 1,
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintTextDirection: TextDirection.ltr,
              ),
              style: const TextStyle(fontSize: 18, color: Colors.white),
              onSubmitted: (value) {
                Navigator.of(context).pop(songController.text);
                songController.clear();
              },
              autofocus: true,
            ),
          ),
        );
      });
}
