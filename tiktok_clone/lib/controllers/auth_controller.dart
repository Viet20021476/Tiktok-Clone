import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user.dart' as models;
import 'package:tiktok_clone/views/screens/authens/login_screen.dart';
import 'package:tiktok_clone/views/screens/mainScreen/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<File?> _pickedImage = Rx<File?>(File('assets/images/clock.png'));
  late Rx<User?> _user;

  File? get profilePhoto => _pickedImage.value;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    firebaseAuth.signOut();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, setInitialScreen);
  }

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
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //save out user to auth and firebase firestore
        UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        String downloadURL = await uploadToStorage(image);
        models.User user = models.User(
            email: email,
            name: username,
            uid: userCredential.user!.uid,
            profilePhoto: downloadURL);
        await firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(user.toJson());
        Get.back();
        Get.snackbar('Register successfully', '');
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

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar('Error logging in', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar('Error logging in', e.toString());
    }
  }

  setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }
}
