import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);
  final Rx<List<int>> _followerCountsList = Rx<List<int>>([]);

  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  List<int> get followerCountsList => _followerCountsList.value;

  List<User> get searchedUsers => _searchedUsers.value;

  searchUser(String typedUser) async {
    _isLoading.value = true;
    if (typedUser != '') {
      _searchedUsers.bindStream(firestore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: typedUser)
          .where('name', isLessThanOrEqualTo: typedUser + '\uF8FF')
          .snapshots()
          .map((QuerySnapshot query) {
        List<User> retVal = [];
        for (var elem in query.docs) {
          retVal.add(User.fromSnap(elem));
        }
        return retVal;
      }));
    } else {
      _searchedUsers.value = [];
    }
    _isLoading.value = false;
  }

  Future<int> getFollowerCount(String uid) async {
    final docUser = await firestore
        .collection('users')
        .doc(uid)
        .collection('followers')
        .get();
    return docUser.docs.length;
  }

  Future<bool> checkIfFollowing(String uid) async {
    DocumentSnapshot doc = await firestore
        .collection('users')
        .doc(uid)
        .collection('followers')
        .doc(authController.user.uid)
        .get();
    return doc.exists;
  }

  followUser(String uid) async {
    var doc = await firestore
        .collection('users')
        .doc(uid)
        .collection('followers')
        .doc(authController.user.uid)
        .get();

    if (!doc.exists) {
      await firestore
          .collection('users')
          .doc(uid)
          .collection('followers')
          .doc(authController.user.uid)
          .set({});
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(uid)
          .set({});
    } else {
      await firestore
          .collection('users')
          .doc(uid)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(uid)
          .delete();
    }
  }
}
