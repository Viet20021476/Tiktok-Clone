import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/search_controller.dart';
import 'package:tiktok_clone/models/user.dart';
import 'package:tiktok_clone/views/screens/mainScreen/profile_screen.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final TextEditingController searchFieldController = TextEditingController();
  final SearchController searchController = Get.put(SearchController());
  bool checkList = false;
  RxBool fieldContainText = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            actions: [
              TextButton(
                  onPressed: () {
                    checkList = true;
                    searchController
                        .searchUser(searchFieldController.value.text);
                    if (searchFieldController.value.text == "") {
                      checkList = true;
                    } else {
                      checkList = false;
                    }
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Text(
                    'Search',
                    style: TextStyle(color: Colors.red),
                  ))
            ],
            title: Container(
              height: 60,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: TextFormField(
                controller: searchFieldController,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                onChanged: (value) {
                  if (value != '') {
                    fieldContainText.value = true;
                  } else {
                    fieldContainText.value = false;
                  }
                },
                decoration: InputDecoration(
                  suffixIcon: fieldContainText.value
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            searchFieldController.clear();
                          },
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                        )
                      : Container(
                          width: 0,
                        ),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.black12,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  prefixIcon: Container(
                    height: 5,
                    decoration: BoxDecoration(),
                    child: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    ),
                  ),
                ),
                onFieldSubmitted: (value) {
                  checkList = true;
                  searchController.searchUser(value);
                  if (value == "") {
                    checkList = true;
                  } else {
                    checkList = false;
                  }
                },
              ),
            ),
          ),
          body: searchController.searchedUsers.isEmpty
              ? Center(
                  child: Text(
                    checkList ? 'Search for users!' : 'No user found!',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ListView.builder(
                    itemCount: searchController.searchedUsers.length,
                    itemBuilder: (context, index) {
                      User user = searchController.searchedUsers[index];
                      RxBool isFollowing = false.obs;
                      return InkWell(
                        onTap: (() async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                uid: user.uid,
                                isFromMethod: true,
                              ),
                            ),
                          );
                        }),
                        child: FutureBuilder(
                            future: searchController.getFollowerCount(user.uid),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      user.profilePhoto,
                                    ),
                                    radius: 30,
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.name,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${snapshot.data} followers',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: user.uid != authController.user.uid
                                      ? StreamBuilder<Object>(
                                          stream: firestore
                                              .collection('users')
                                              .doc(user.uid)
                                              .collection('followers')
                                              .doc(authController.user.uid)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              var docs = snapshot.data!
                                                  as DocumentSnapshot;
                                              return Container(
                                                height: 36,
                                                width: 80,
                                                child: TextButton(
                                                    onPressed: () {
                                                      print(
                                                          docs.data() == null);

                                                      searchController
                                                          .followUser(user.uid);
                                                    },
                                                    child: Text(
                                                      docs.data() == null
                                                          ? 'Follow'
                                                          : 'Following',
                                                      style: TextStyle(
                                                          color: docs.data() ==
                                                                  null
                                                              ? Colors.white
                                                              : Colors.black),
                                                    )),
                                                decoration: docs.data() == null
                                                    ? BoxDecoration(
                                                        color: Colors.red)
                                                    : BoxDecoration(
                                                        border: Border.all(
                                                            width: 1.0,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    204,
                                                                    186,
                                                                    186))),
                                              );
                                            } else {
                                              return Container(
                                                width: 40,
                                                height: 40,
                                                color: Colors.red,
                                              );
                                            }
                                          })
                                      : Container(
                                          width: 10,
                                          height: 10,
                                        ),
                                ),
                              );
                            }),
                      );
                    },
                  ),
                ));
    });
  }
}
