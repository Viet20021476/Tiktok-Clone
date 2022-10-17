import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/views/screens/mainScreen/add_video_screen.dart';
import 'package:tiktok_clone/views/screens/mainScreen/messages_screen.dart';
import 'package:tiktok_clone/views/screens/mainScreen/profile_screen.dart';
import 'package:tiktok_clone/views/screens/mainScreen/search_screen.dart';
import 'package:tiktok_clone/views/screens/mainScreen/video_screen.dart';

const backGroundColor = Colors.white;
const backGroundColor2 = Colors.black;
var buttonColor = Colors.red;
var borderColor = Colors.blueGrey;

List pages = [
  VideoScreen(),
  const SearchScreen(),
  const AddVideoScreen(),
  const MessagesScreen(),
  const ProfileScreen(),
];

//firebase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//Controller
var authController = AuthController.instance;
