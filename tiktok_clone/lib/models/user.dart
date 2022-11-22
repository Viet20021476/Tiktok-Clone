import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String email;
  String uid;
  String profilePhoto;
  String tiktokID;
  String bio;

  User(
      {required this.name,
      required this.email,
      required this.uid,
      required this.profilePhoto,
      required this.tiktokID,
      required this.bio});

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "profilePhoto": profilePhoto,
      "tiktokID": tiktokID,
      "bio": bio
    };
  }

  static User fromSnap(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return User(
        name: snapshot['name'],
        email: snapshot['email'],
        uid: snapshot['uid'],
        profilePhoto: snapshot['profilePhoto'],
        tiktokID: snapshot['tiktokID'],
        bio: snapshot['bio']);
  }
}
