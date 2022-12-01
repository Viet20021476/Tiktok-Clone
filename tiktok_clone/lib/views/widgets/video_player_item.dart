import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  VideoPlayerController videoPlayerController;
  VideoPlayerItem(
      {Key? key, required this.videoUrl, required this.videoPlayerController})
      : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  // late VideoPlayerController videoPlayerController;
  late Future _initializeVideoPlayer;
  bool isPlaying = true;

  late Rx<String> currentRoute;

  @override
  void initState() {
    super.initState();
    // videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayer =
        widget.videoPlayerController.initialize().then((value) {
      widget.videoPlayerController.play();
      widget.videoPlayerController.setVolume(1);
      widget.videoPlayerController.setLooping(true);
      widget.videoPlayerController.addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    });
    print('init' + widget.videoPlayerController.toString());
  }

  @override
  void dispose() {
    print('dispose' + widget.videoPlayerController.toString());
    widget.videoPlayerController.dispose();
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
                                widget.videoPlayerController.value.aspectRatio,
                            child: VideoPlayer(widget.videoPlayerController)),
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
                        ? widget.videoPlayerController.pause()
                        : widget.videoPlayerController.play();
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                  },
                );
        });
  }
}
