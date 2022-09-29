import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/screens/mainScreen/messages_screen.dart';
import 'package:tiktok_clone/views/screens/mainScreen/profile_screen.dart';

const backGroundColor = Colors.white;
const backGroundColor2 = Colors.black;
var buttonColor = Colors.red;
var borderColor = Colors.blueGrey;

const pages = [
  Text("Home Screen"),
  Text("Search Screen"),
  Text("Add page Screen"),
  const MessagesScreen(),
  const ProfileScreen(),
];
