import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/video.dart';
import 'package:tiktok_clone/views/screens/mainScreen/home_screen.dart';

class UploadVideoController extends GetxController {
  late UploadTask? uploadTask = null;
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  _compressVideo(String videoPath) {
    final compressedVideo = File(videoPath);
    return compressedVideo;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child("videos").child(id);
    uploadTask = ref.putFile(_compressVideo(videoPath));
    _isLoading.value = true;
    print('video 1');
    TaskSnapshot? snap = await uploadTask;
    print('video 2');

    String downloadUrl = await snap!.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> _uploadImageToStorage(String id, String thumbnailPath) async {
    Reference ref = firebaseStorage.ref().child("thumbnails").child(id);

    UploadTask uploadTask = ref.putFile(_getThumbnail(thumbnailPath));
    print('video 3');

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String thumbnailPath) {
    final thumbnail = File(thumbnailPath);
    return thumbnail;
  }

  uploadVideo(String songName, String caption, String videoPath,
      String videoThumbnailUrl) async {
    try {
      if (getInterenetStatus() != ConnectivityResult.none.toString()) {
        String uid = authController.user.uid;
        DocumentSnapshot userDoc =
            await firestore.collection("users").doc(uid).get();

        var allDocs = await firestore.collection("videos").get();
        int len = allDocs.docs.length;

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
        _isLoading.value = false;

        Get.offAll(HomeScreen());
      } else {
        final snackbar =
            createSnackbar('No internet connection', '', ContentType.failure);
        snackbarKey.currentState?.showSnackBar(snackbar);
      }
    } catch (e) {
      cancelUpload();
      Get.snackbar("Error uploading video", e.toString());
    }
  }

  Widget buildUploadStatus() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            );
          } else {
            uploadTask = null;
            return Container();
          }
        },
      );

  void cancelUpload() {
    try {
      if (uploadTask != null) {
        uploadTask?.cancel();
        uploadTask = null;
        Get.back();
      }
    } catch (e) {}
  }
}
