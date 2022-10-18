import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentScreen extends StatelessWidget {
  final String id;

  CommentScreen({super.key, required this.id});
  final TextEditingController commentTextController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(id);
    return Obx(() {
      return SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
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
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
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
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
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
                                    color: Colors.black,
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
                  child: ListTile(
                    title: TextField(
                      controller: commentTextController,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Comment',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        commentController
                            .postComment(commentTextController.text);
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
                ),
              ],
            )),
      );
    });
  }
}
