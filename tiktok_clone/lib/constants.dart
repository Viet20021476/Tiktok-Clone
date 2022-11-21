import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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

late File file;
final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

List pages = [
  VideoScreen(
    uid: '',
    thumbnail: 0,
  ),
  SearchScreen(),
  const AddVideoScreen(),
  const MessagesScreen(),
  ProfileScreen(
    uid: authController.user.uid,
    isFromMethod: false,
  ),
];

getInterenetStatus() async {
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult result = ConnectivityResult.none;
  try {
    result = await _connectivity.checkConnectivity();
  } on PlatformException catch (e) {
    print(e.toString());
  }
  return result.toString();
}

createSnackbar(String title, String message, ContentType contentType) {
  return SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      color: Colors.blueAccent.shade700,
      message: message,
      contentType: contentType,
    ),
  );
}

Future<File> imageToFile(
    {required String imageName, required String ext}) async {
  var bytes = await rootBundle.load('assets/$imageName.$ext');
  String tempPath = (await getTemporaryDirectory()).path;
  File file = File('$tempPath/profile.png');
  await file.writeAsBytes(
      bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
  return file;
}

//firebase
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//Controller
var authController = AuthController.instance;
