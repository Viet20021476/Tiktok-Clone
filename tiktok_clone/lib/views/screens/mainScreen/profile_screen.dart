import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/profile_controller.dart';
import 'package:tiktok_clone/views/screens/mainScreen/edit_profile_screen.dart';
import 'package:tiktok_clone/views/screens/mainScreen/profiletab_1.dart';
import 'package:tiktok_clone/views/screens/mainScreen/profiletab_2.dart';
import 'package:tiktok_clone/views/screens/mainScreen/profiletab_3.dart';
import 'package:tiktok_clone/views/screens/mainScreen/setting_screen.dart';

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
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.isLoading) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: Colors.white),
              alignment: Alignment.center,
              child: Lottie.asset(
                'assets/my-icons/tiktok_loader.json',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            );
          }
          print(controller.user['tiktokID']);
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
                actions: [
                  InkWell(
                    onTap: () {
                      widget.uid == authController.user.uid
                          ? Get.to(() => SettingScreen(
                                controller: profileController,
                              ))
                          : {print('route' + Get.currentRoute)};
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: ImageIcon(
                        AssetImage('assets/my-icons/menuicon.png'),
                        color: Colors.black,
                      ),
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
                  child: Text('@' + controller.user['tiktokID'],
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
                            color: widget.uid == authController.user.uid
                                ? Colors.white
                                : !controller.user['isFollowing']
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
                          style: widget.uid == authController.user.uid
                              ? const TextStyle(
                                  color: Colors.black, fontSize: 14)
                              : !controller.user['isFollowing']
                                  ? const TextStyle(
                                      color: Colors.white, fontSize: 14)
                                  : const TextStyle(
                                      color: Colors.black, fontSize: 14),
                        ),
                      ),
                      onTap: () {
                        if (widget.uid == authController.user.uid) {
                          Get.to(
                              () => EditProfileScreen(controller: controller));
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

                InkWell(
                  onTap: (() {}),
                  child: Text(
                    controller.user['bio'] == ''
                        ? "User bio here"
                        : controller.user['bio'],
                    style: TextStyle(color: Colors.grey[700]),
                    textAlign: TextAlign.center,
                  ),
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
                  backgroundColor: Color.fromARGB(255, 196, 182, 182),
                  child: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
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
