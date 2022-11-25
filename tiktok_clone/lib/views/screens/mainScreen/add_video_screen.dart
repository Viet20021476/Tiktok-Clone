import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/main.dart';

import 'confirm_screen.dart';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  // pickVideo(ImageSource src, BuildContext context) async {

  CameraController _cameraController =
      CameraController(cameras.first, ResolutionPreset.medium);
  PageController _pageController =
      PageController(initialPage: 1, viewportFraction: 0.2);
  int _selectedTab = 1;
  bool isRecording = false;

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);

    if (video != null) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ConfirmScreen(
                videoFile: File(video.path),
                videoPath: video.path,
              )));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraController.initialize().then((_) {
      if (!mounted) return;

      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          if (_cameraController.value.isInitialized) _buildCameraPreview(),
          Spacer(),
          Container(
            color: Colors.black,
            height: 90,
            child: _buildCameraTemplateSelector(),
          )
        ],
      ),
    );
  }

  Widget _buildCameraPreview() {
    final style = Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold);

    return Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).size.height / 5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: 1.5,
            child: CameraPreview(_cameraController),
            alignment: Alignment.center,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 75, left: 24, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            child: Icon(
                              CupertinoIcons.music_note_2,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                          Text(
                            "Add sound",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildIconWithText(
                              'rotate_camera', 'Rotate', style, 25),
                          _buildIconWithText('beauty', 'Beauty', style, 25),
                          _buildIconWithText('filter', 'Filter', style, 25),
                          _buildIconWithText('flash', 'Flash', style, 25)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              _buildCameraTypeSelector(),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildIconWithText(
                        "effects", "Effects", style.copyWith(fontSize: 11), 40),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 4),
                          borderRadius: BorderRadius.circular(38)),
                      child: GestureDetector(
                        onTap: () async {
                          if (isRecording) {
                            _cameraController.stopVideoRecording();

                            setState(() {
                              isRecording = false;
                            });
                          }
                          await _cameraController.startVideoRecording();
                          setState(() {
                            isRecording = true;
                          });
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.white, radius: 28),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => pickVideo(ImageSource.gallery, context),
                      child: _buildIconWithText(
                          "upload", "Upload", style.copyWith(fontSize: 11), 40),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCameraTypeSelector() {
    final List<String> cameraTypes = ["Photo", "Video"];

    TextStyle style = Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 65,
          height: 25,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(50)),
        ),
        Container(
          height: 45,
          child: PageView.builder(
              controller: _pageController,
              itemCount: cameraTypes.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  child: Text(
                    cameraTypes[index],
                    style: style.copyWith(color: Colors.white),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget _buildIconWithText(
      String icon, String label, TextStyle style, double size) {
    return Column(
      children: [
        Image.asset(
          'assets/my-icons/$icon.png',
          width: size,
          height: size,
        ),
        SizedBox(
          height: 5,
        ),
        Text(label, style: style)
      ],
    );
  }

  Widget _buildCameraTemplateSelector() {
    final List<String> postTypes = ["Camera", "Quick", "Template"];
    TextStyle style = Theme.of(context).textTheme.bodyText1!.copyWith(
        fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 45,
          child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) => {
                    setState(() {
                      _selectedTab = page;
                    })
                  },
              itemCount: postTypes.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  child: Text(
                    postTypes[index],
                    style: style.copyWith(
                        color:
                            _selectedTab == index ? Colors.white : Colors.grey),
                  ),
                );
              }),
        ),
        Container(
          width: 50,
          height: 45,
          alignment: Alignment.bottomCenter,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 2.5,
          ),
        )
      ],
    );
  }
}
