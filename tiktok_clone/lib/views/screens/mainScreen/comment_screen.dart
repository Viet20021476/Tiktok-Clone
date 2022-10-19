import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentScreen extends StatefulWidget {
  final String id;

  CommentScreen({super.key, required this.id});
  static TextEditingController commentTextController = TextEditingController();

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  var sendButtonVisible = true.obs;

  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(widget.id);
    commentController.getProfilePhoto();
    return Obx(() {
      return SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
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
                              child: Icon(
                                Icons.favorite,
                                size: 25,
                                color: !comment.likes
                                        .contains(authController.user.uid)
                                    ? Colors.white
                                    : Colors.red,
                              ),
                            ),
                          );
                        }))),
                const Divider(),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.black,
                        backgroundImage:
                            NetworkImage(commentController.userPhoto),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          onTap: () {
                            print('hi');
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
                            fillColor: Colors.white24,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 4),
                            hintText: 'Add comment',
                            hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.black38,
                              fontWeight: FontWeight.w400,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: sendButtonVisible.value,
                        child: TextButton(
                          onPressed: () {
                            commentController.postComment(
                                CommentScreen.commentTextController.text);
                            CommentScreen.commentTextController.clear();
                            FocusScope.of(context).requestFocus(FocusNode());
                            // sendButtonVisible.value = false;
                          },
                          child: const Text(
                            'Send',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                )
              ],
            )),
      );
    });
  }
}
