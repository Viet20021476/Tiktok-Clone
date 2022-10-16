import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user.dart' as models;

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          'You has sucessfully selected your profile picture');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  //register the user
  void registerUser(
      String userName, String email, String password, File? image) async {
    try {
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //save out user to auth and firebase firestore
        UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        String downloadURL = await uploadToStorage(image);
        models.User user = models.User(
            email: email,
            name: userName,
            uid: userCredential.user!.uid,
            profilePhoto: downloadURL);
        await firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('Fail', 'Please enter all the field');
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error creating acount', e.toString());
    }
  }

  Future<String> uploadToStorage(File? image) async {
    Reference reference = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(image!);
    TaskSnapshot snap = await uploadTask;
    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }
}
