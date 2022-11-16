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
    videoPlayerController = VideoPlayerController.network(
        'https://v16-webapp.tiktok.com/1bc5e60c23467b17f51f4df30aa4f209/63753874/video/tos/useast2a/tos-useast2a-pve-0037-aiso/bb980d063a3a4be989bccee5f78f5cac/?a=1988&ch=0&cr=0&dr=0&lr=tiktok&cd=0%7C0%7C1%7C0&cv=1&br=1540&bt=770&cs=0&ds=3&ft=kLO5qy-gZmo0P8INDBkVQNixDiHKJdmC0&mime_type=video_mp4&qs=0&rc=OmRpPGc8OzUzOGc7NjY3ZkBpMzQ6aDY6ZndtZzMzZjgzM0AxLy1hXy8wXzUxNTUuM2FfYSNqaXIzcjRfM21gLS1kL2Nzcw%3D%3D&l=202211161321340102510582202613C249&btag=80000')
      ..initialize().then((value) {
        videoPlayerController.play();
        videoPlayerController.setVolume(1);
        videoPlayerController.setLooping(true);
      });
    videoPlayerController.addListener(() {
      setState(() {});
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
    return GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: AspectRatio(
                aspectRatio: videoPlayerController.value.aspectRatio,
                child: VideoPlayer(videoPlayerController)),
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
            ? videoPlayerController.pause()
            : videoPlayerController.play();
        setState(() {
          isPlaying = !isPlaying;
        });
      },
    );
  }
}
