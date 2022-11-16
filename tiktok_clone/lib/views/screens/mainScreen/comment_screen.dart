import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentScreen extends StatefulWidget {
  final String id;

  // ignore: prefer_const_constructors_in_immutables
  CommentScreen({super.key, required this.id});
  static TextEditingController commentTextController = TextEditingController();

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  var sendButtonVisible = false.obs;

  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(widget.id);
    commentController.getProfilePhoto();
    return Obx(() {
      return SingleChildScrollView(
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                  child: Center(
                      child: Text(
                          '${commentController.commentList.length} comments')),
                ),
                Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: commentController.commentList.length,
                        itemBuilder: ((context, index) {
                          final comment = commentController.commentList[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.black,
                              backgroundImage:
                                  NetworkImage(comment.profilePhoto),
                            ),
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      comment.username,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        comment.comment,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  timeago
                                      .format(comment.datePublished.toDate()),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${comment.likes.length} likes',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            trailing: InkWell(
                              onTap: () {
                                commentController.likeComment(comment.id);
                              },
                              child: !comment.likes
                                      .contains(authController.user.uid)
                                  ? const ImageIcon(
                                      AssetImage('assets/my-icons/heart.png'),
                                      size: 25,
                                      color: Colors.black,
                                    )
                                  : const ImageIcon(
                                      AssetImage(
                                          'assets/my-icons/red_heart.png'),
                                      size: 25,
                                    ),
                            ),
                          );
                        }))),
                Container(
                  height: 10,
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 233, 234, 235)))),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.black,
                        backgroundImage:
                            NetworkImage(commentController.userPhoto),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            if (value != '') {
                              sendButtonVisible.value = true;
                            } else {
                              sendButtonVisible.value = false;
                            }
                          },
                          textInputAction: TextInputAction.done,
                          controller: CommentScreen.commentTextController,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.black12,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            hintText: 'Add comment',
                            hintStyle: const TextStyle(
                              fontSize: 13,
                              color: Colors.black38,
                              fontWeight: FontWeight.w400,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: sendButtonVisible.value,
                        child: InkWell(
                          onTap: () {
                            commentController.postComment(
                                CommentScreen.commentTextController.text);
                            CommentScreen.commentTextController.clear();
                            FocusScope.of(context).requestFocus(FocusNode());
                            sendButtonVisible.value = false;
                          },
                          child: SizedBox(
                              width: 28,
                              height: 28,
                              child: Stack(children: <Widget>[
                                Positioned(
                                    top: 1.1668000221252441,
                                    left: 1.1664999723434448,
                                    child: Image.asset(
                                      'assets/my-icons/post.png',
                                    )),
                                Positioned(
                                    top: 7.388912200927734,
                                    left: 7.632322788238525,
                                    child: Image.asset(
                                      'assets/my-icons/post_1.png',
                                    )),
                              ])),
                        ),
                      ),
                      Visibility(
                        visible: sendButtonVisible.value,
                        child: const SizedBox(
                          width: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            )),
      );
    });
  }
}
