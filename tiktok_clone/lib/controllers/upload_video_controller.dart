import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/video.dart';
import 'package:tiktok_clone/views/screens/mainScreen/home_screen.dart';

class UploadVideoController extends GetxController {
  late UploadTask uploadTask;
  bool isLoading = false;

  _compressVideo(String videoPath) async {
    final compressedVideo = await File(videoPath);
    return compressedVideo;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child("videos").child(id);
    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> _uploadImageToStorage(String id, String thumbnailPath) async {
    Reference ref = firebaseStorage.ref().child("thumbnails").child(id);

    UploadTask uploadTask = ref.putFile(await _getThumbnail(thumbnailPath));

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String thumbnailPath) async {
    final thumbnail = File(thumbnailPath);
    return thumbnail;
  }

  uploadVideo(String songName, String caption, String videoPath,
      String videoThumbnailUrl) async {
    try {
      String uid = authController.user.uid;
      DocumentSnapshot userDoc =
          await firestore.collection("users").doc(uid).get();

      var allDocs = await firestore.collection("videos").get();
      int len = allDocs.docs.length;
      isLoading = true;

      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      String thumbnail =
          await _uploadImageToStorage("Video $len", videoThumbnailUrl);

      Video video = Video(
          userName: (userDoc.data()! as Map<String, dynamic>)["name"],
          uid: uid,
          id: "Video $len",
          likes: [],
          commentCount: 0,
          shareCount: 0,
          songName: songName,
          caption: caption,
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          profilePhoto:
              (userDoc.data()! as Map<String, dynamic>)["profilePhoto"]);

      await firestore
          .collection("videos")
          .doc("Video $len")
          .set(video.toJson());
      isLoading = false;
      Get.offAll(() => HomeScreen());
    } catch (e) {
      Get.snackbar("Error uploading video", e.toString());
    }
  }

  void cancelUploadTask() {
    print(uploadTask);
  }
}
