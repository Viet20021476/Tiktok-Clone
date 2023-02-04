import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  String tag;
  int index;
  // VideoPlayerController videoPlayerController;
  VideoPlayerItem(
      {Key? key, required this.videoUrl, required this.tag, required this.index
      /*required this.videoPlayerController*/
      })
      : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  late Future _initializeVideoPlayer;
  bool isPlaying = true;

  late Rx<String> currentRoute;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayer = videoPlayerController.initialize().then((value) {
      videoPlayerController.play();
      videoPlayerController.setVolume(1);
      videoPlayerController.setLooping(true);
      videoPlayerController.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    });
    Get.put(videoPlayerController, tag: widget.tag + widget.index.toString());
    print('init' + videoPlayerController.toString());
  }

  @override
  void dispose() {
    print('dispose' + videoPlayerController.toString());
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeVideoPlayer,
        builder: (context, snapshot) {
          return snapshot.connectionState != ConnectionState.done
              ? Container(
                  alignment: Alignment.center,
                  child: Lottie.asset(
                    'assets/my-icons/tiktok_loader.json',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                )
              : GestureDetector(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                      ),
                      Center(
                        child: AspectRatio(
                            aspectRatio:
                                videoPlayerController.value.aspectRatio,
                            child: VideoPlayer(videoPlayerController)),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.play_arrow,
                          size: 60,
                          color: Colors.white.withOpacity(isPlaying ? 0 : 0.5),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    print(Get.currentRoute);
                    isPlaying
                        ? videoPlayerController.pause()
                        : videoPlayerController.play();
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                  },
                );
        });
  }
}
