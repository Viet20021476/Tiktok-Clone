import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/video_controller.dart';
import 'package:tiktok_clone/views/screens/mainScreen/comment_screen.dart';
import 'package:tiktok_clone/views/screens/mainScreen/profile_screen.dart';
import 'package:tiktok_clone/views/widgets/circle_animation.dart';
import 'package:tiktok_clone/views/widgets/tik_tok_icons.dart';
import 'package:tiktok_clone/views/widgets/video_player_item.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final VideoController videoController = Get.put(VideoController());

  bool _isFollowingSeleted = false;

  buildMusicAlbum(String profilePhoto) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 36, 34, 34),
                Color.fromARGB(255, 209, 204, 204)
              ]),
              borderRadius: BorderRadius.circular(25)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image(
              image: NetworkImage(profilePhoto),
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }

  buildProfile(
      String profilePhoto, String uid, VideoPlayerItem videoPlayerItem) {
    return SizedBox(
      width: 50,
      height: 60,
      child: Stack(
        children: [
          InkWell(
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onTap: () async {
              // Get.to(() => VideoScreen());
              // videoPlayerItem.pauseVideo();
              Get.to(() => ProfileScreen(
                    uid: uid,
                    isFromMethod: true,
                  ));
              // final checkData = await Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ProfileScreen(
              //               uid: uid,
              //               isFromMethod: true,
              //             )));
              // setState(() {
              //   print(checkData);
              //   if (checkData != null) {
              //     // videoPlayerItem.playVideo();
              //   } else {
              //     // videoPlayerItem.playVideo();
              //   }
              // });
            },
          ),
          Positioned(
            bottom: 1,
            left: 15,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.red),
              child: const Center(
                  child: Icon(
                Icons.add,
                color: Colors.white,
                size: 15,
              )),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backGroundColor2,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: GestureDetector(
          onTap: () {
            setState(() {
              _isFollowingSeleted = !_isFollowingSeleted;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Following',
                style: TextStyle(
                    fontSize: _isFollowingSeleted ? 18 : 14,
                    color: _isFollowingSeleted ? Colors.white : Colors.grey),
              ),
              const Text('  |  ',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              Text('For you',
                  style: TextStyle(
                      fontSize: !_isFollowingSeleted ? 18 : 14,
                      color:
                          !_isFollowingSeleted ? Colors.white : Colors.grey)),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Obx(() {
        return PageView.builder(
            itemCount: videoController.videoList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final data = videoController.videoList[index];
              VideoPlayerItem videoPlayerItem =
                  VideoPlayerItem(videoUrl: data.videoUrl);
              return Stack(
                children: [
                  videoPlayerItem,
                  Column(
                    children: [
                      const SizedBox(height: 100),
                      Expanded(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.only(left: 8, bottom: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('@${data.userName}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 8,
                                ),
                                ExpandableText(
                                  data.caption,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                  expandText: 'more',
                                  collapseText: 'less',
                                  collapseOnTextTap: true,
                                  expandOnTextTap: true,
                                  maxLines: 2,
                                  linkColor: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    const Icon(CupertinoIcons.music_note_2,
                                        size: 15, color: Colors.white),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    SizedBox(
                                      height: 20,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Marquee(
                                          text: '${data.songName}    •   ',
                                          velocity: 8,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                          SizedBox(
                            width: size.width * 0.1,
                          ),
                          SizedBox(
                            width: 60,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  buildProfile(data.profilePhoto, data.uid,
                                      videoPlayerItem),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            videoController.likeVideo(data.id);
                                          },
                                          child: Icon(TikTokIcons.heart,
                                              size: 36,
                                              color: data.likes.contains(
                                                      authController.user.uid)
                                                  ? Colors.red
                                                  : Colors.white)),
                                      const SizedBox(height: 6),
                                      Text(data.likes.length.toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            showCommentBottomSheet(
                                                context, data.id);
                                          },
                                          child: const Icon(
                                              TikTokIcons.chatBubble,
                                              size: 36,
                                              color: Colors.white)),
                                      const SizedBox(height: 6),
                                      Text(data.commentCount.toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                          onTap: () {},
                                          child: const Icon(TikTokIcons.reply,
                                              size: 27, color: Colors.white)),
                                      const SizedBox(height: 6),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(data.shareCount.toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CircleAnimation(
                                      child:
                                          buildMusicAlbum(data.profilePhoto)),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ))
                    ],
                  )
                ],
              );
            });
      }),
    );
  }

  void showCommentBottomSheet(BuildContext context, String id) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return CommentScreen(
            id: id,
          );
        });
  }
}
