import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/search_controller.dart';
import 'package:tiktok_clone/models/user.dart';
import 'package:tiktok_clone/views/screens/mainScreen/profile_screen.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final SearchController searchController = Get.put(SearchController());
  bool checkList = true;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: TextFormField(
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onFieldSubmitted: (value) {
                searchController.searchUser(value);
                if (value == "") {
                  checkList = true;
                } else {
                  checkList = false;
                }
              },
            ),
          ),
          body: searchController.searchedUsers.isEmpty || checkList
              ? const Center(
                  child: Text(
                    'Search for users!',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: searchController.searchedUsers.length,
                  itemBuilder: (context, index) {
                    User user = searchController.searchedUsers[index];
                    return InkWell(
                      onTap: (() {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                        //         ProfileScreen(uid: user.uid)));
                        Get.to(ProfileScreen(uid: user.uid));
                      }),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            user.profilePhoto,
                          ),
                        ),
                        title: Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ));
    });
  }
}
