import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  final Rx<List<Video>> _profileVideoList = Rx<List<Video>>([]);

  List<Video> get profileVideoList => _profileVideoList.value;

  @override
  void onInit() {
    // Init videoController
    super.onInit();
    _videoList.bindStream(firestore
        .collection("videos")
        .orderBy("id", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Video> res = [];
      print('bind video');
      for (var el in query.docs) {
        res.add(Video.fromSnap(el));
      }
      return res;
    }));
  }

  likeVideo(String id) async {
    DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
    var uid = authController.user.uid;
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }

  getProfileVideos(String uid) async {
    _profileVideoList.value = await firestore
        .collection('videos')
        .where('uid', isEqualTo: uid)
        .get()
        .then((querySnapshot) {
      List<Video> res = [];
      for (var el in querySnapshot.docs) {
        res.add(Video.fromSnap(el));
      }
      return res;
    });
  }
}
