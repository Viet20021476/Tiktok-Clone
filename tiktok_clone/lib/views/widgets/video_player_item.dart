import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  VideoPlayerItem({Key? key, required this.videoUrl}) : super(key: key);
  _VideoPlayerItemState _videoPlayerItemState = _VideoPlayerItemState();

  @override
  State<VideoPlayerItem> createState() => _videoPlayerItemState;

  void pauseVideo() {
    print('pause' + _videoPlayerItemState.videoPlayerController.toString());
    _videoPlayerItemState.videoPlayerController?.pause();
  }

  void playVideo() {
    print('play' + _videoPlayerItemState.videoPlayerController.toString());
    _videoPlayerItemState.videoPlayerController?.play();
  }
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController? videoPlayerController;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    videoPlayerController?.initialize().then((value) {
      videoPlayerController!.play();
      videoPlayerController!.setVolume(1);
      videoPlayerController!.setLooping(true);
    });
    videoPlayerController!.addListener(() {
      setState(() {});
    });
    print('init' + videoPlayerController.toString());
  }

  @override
  void dispose() {
    print('dispose' + videoPlayerController.toString());
    super.dispose();
    videoPlayerController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
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
                aspectRatio: videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(videoPlayerController!)),
          ),
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
            ? videoPlayerController!.pause()
            : videoPlayerController!.play();
        setState(() {
          isPlaying = !isPlaying;
        });
      },
    );
  }
}
