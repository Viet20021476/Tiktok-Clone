import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/screens/mainScreen/profiletab_1.dart';
import 'package:tiktok_clone/views/screens/mainScreen/profiletab_2.dart';
import 'package:tiktok_clone/views/screens/mainScreen/profiletab_3.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Text(
              "Hello",
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Icon(Icons.person_add, color: Colors.black),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Column(children: [
          // Profile photo
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
                image: DecorationImage(
                    image: NetworkImage(
                        "https://media.giphy.com/media/tqfS3mgQU28ko/giphy.gif"),
                    fit: BoxFit.fill)),
          ),

          // user name
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("@Testuser",
                style: TextStyle(color: Colors.black, fontSize: 15)),
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
                      Text("12",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      SizedBox(height: 5),
                      Text("Following",
                          style: TextStyle(color: Colors.grey, fontSize: 15))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Text("34",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                      SizedBox(height: 5),
                      Text("Followers",
                          style: TextStyle(color: Colors.grey, fontSize: 15))
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text("56",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    SizedBox(height: 5),
                    Text("   Likes   ",
                        style: TextStyle(color: Colors.grey, fontSize: 15))
                  ],
                ),
              ))
            ],
          ),

          SizedBox(height: 15),

          // buttons -> edit profile, insta links, bookmark

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                child: Text(
                  "Edit profile",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(5)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Container(
                  padding: EdgeInsets.all(11),
                  child: Icon(Icons.camera_alt, color: Colors.black),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              Container(
                padding: EdgeInsets.all(11),
                child: Icon(
                  Icons.bookmark_border,
                  color: Colors.grey[800],
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(5)),
              )
            ],
          ),
          SizedBox(height: 15),
          // bio
          Text(
            "User bio here",
            style: TextStyle(color: Colors.grey[700]),
          ),

          // default tab controller

          TabBar(tabs: [
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
            children: [FirstTab(), SecondTab(), ThirdTab()],
          ))
        ]),
      ),
    );
  }
}
