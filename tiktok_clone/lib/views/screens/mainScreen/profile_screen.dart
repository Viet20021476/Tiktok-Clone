import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/profile_controller.dart';
import 'package:tiktok_clone/views/screens/mainScreen/profiletab_1.dart';
import 'package:tiktok_clone/views/screens/mainScreen/profiletab_2.dart';
import 'package:tiktok_clone/views/screens/mainScreen/profiletab_3.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  final bool isFromMethod;
  const ProfileScreen({Key? key, required this.uid, required this.isFromMethod})
      : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.user['name'],
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    widget.uid == authController.user.uid &&
                            !widget.isFromMethod
                        ? InkWell(
                            onTap: (() {
                              showSignOutBottomSheet(context, controller);
                            }),
                            child: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                          )
                        : Container(),
                  ],
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: widget.uid == authController.user.uid &&
                        !widget.isFromMethod
                    ? const ImageIcon(
                        AssetImage('assets/my-icons/friend.png'),
                        color: Colors.black,
                        size: 200,
                      )
                    : InkWell(
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Get.back();
                        },
                      ),
                actions: const [
                  Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: ImageIcon(
                      AssetImage('assets/my-icons/menuicon.png'),
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              body: Column(children: [
                // Profile photo
                CircleAvatar(
                  radius: 38,
                  backgroundImage:
                      NetworkImage(controller.user['profilePhoto']),
                ),

                // user name
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('@${controller.user['name']}',
                      style:
                          const TextStyle(color: Colors.black, fontSize: 15)),
                ),

                // number of following, followers, likes

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            Text(controller.user['following'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            const SizedBox(height: 5),
                            const Text("Following",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: Column(
                          children: [
                            Text(controller.user['followers'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            const SizedBox(height: 5),
                            const Text("Followers",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 15))
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Text(controller.user['likes'],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          const SizedBox(height: 5),
                          const Text("   Likes   ",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15))
                        ],
                      ),
                    ))
                  ],
                ),

                const SizedBox(height: 15),

                // buttons -> edit profile, insta links, bookmark

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 40),
                        decoration: BoxDecoration(
                            color: controller.user['isFollowing']
                                ? Colors.red
                                : Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          widget.uid == authController.user.uid
                              ? "Edit profile"
                              : controller.user['isFollowing']
                                  ? 'Unfollow'
                                  : 'Follow',
                          style: controller.user['isFollowing']
                              ? const TextStyle(
                                  color: Colors.white, fontSize: 14)
                              : const TextStyle(
                                  color: Colors.black, fontSize: 14),
                        ),
                      ),
                      onTap: () {
                        if (widget.uid == authController.user.uid) {
                          authController.signOutUser();
                        } else {
                          controller.followUser();
                        }
                      },
                    ),
                    widget.uid == authController.user.uid
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Container(
                              padding: const EdgeInsets.all(11),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Icon(Icons.camera_alt,
                                  color: Colors.black),
                            ),
                          )
                        : Container(),
                    widget.uid == authController.user.uid
                        ? Container(
                            padding: const EdgeInsets.all(11),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              Icons.bookmark_border,
                              color: Colors.grey[800],
                            ),
                          )
                        : Container()
                  ],
                ),
                const SizedBox(height: 15),
                // bio
                Text(
                  "User bio here",
                  style: TextStyle(color: Colors.grey[700]),
                ),

                // default tab controller

                const TabBar(tabs: [
                  Tab(
                    icon: Icon(
                      Icons.grid_3x3,
                      color: Colors.black,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.black,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.black,
                    ),
                  )
                ]),
                Expanded(
                    child: TabBarView(
                  children: [
                    FirstTab(
                      controller: controller,
                    ),
                    const SecondTab(),
                    const ThirdTab()
                  ],
                ))
              ]),
            ),
          );
        });
  }

  void showSignOutBottomSheet(
      BuildContext context, ProfileController controller) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              const SizedBox(
                height: 50,
                child: Center(
                    child: Text(
                  'Change account',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage:
                      NetworkImage(controller.user['profilePhoto']),
                ),
                title: Text(controller.user['name']),
                trailing: const Icon(
                  Icons.check,
                  color: Colors.red,
                ),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/3168/3168166.png'),
                ),
                title: const Text(
                  'Sign out',
                ),
                onTap: (() {
                  authController.signOutUser();
                }),
              ),
            ]),
          );
        });
  }
}
