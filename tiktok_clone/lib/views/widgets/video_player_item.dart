import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        videoPlayerController.play();
        videoPlayerController.setVolume(1);
        videoPlayerController.setLooping(true);
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(color: Colors.black),
      child: GestureDetector(
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(videoPlayerController),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.play_arrow,
                size: 60,
                color: Colors.white.withOpacity(isPlaying ? 0 : 0.5),
              ),
            )
          ],
        ),
        onTap: () {
          isPlaying
              ? videoPlayerController.pause()
              : videoPlayerController.play();
          setState(() {
            isPlaying = !isPlaying;
          });
        },
      ),
    );
  }
}
