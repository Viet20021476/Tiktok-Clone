import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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

  late Rx<File> _pickedImage = Rx<File>(file);
  late Rx<User?> _user;

  File get profilePhoto => _pickedImage.value;

  User get user => _user.value!;

  @override
  void onReady() async {
    super.onReady();
    await firebaseAuth.signOut();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    file = await imageToFile(imageName: 'images/avatar', ext: 'png');
    // ever(_user, setInitialScreen);
  }

  void setPickedImage(File file) {
    _pickedImage.value = file;
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          'You has sucessfully selected your profile picture');
      setPickedImage(File(pickedImage.path));
    }
  }

  void signOutUser() async {
    await firebaseAuth.signOut();
    if (_user == null) {
      Get.offAll(() => LoginScreen());
    }
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
        final snackbar =
            createSnackbar('Register successfully', '', ContentType.success);
        snackbarKey.currentState?.showSnackBar(snackbar);
      } else {
        final snackbar = createSnackbar(
            'Fail', 'Please enter all the field', ContentType.warning);
        snackbarKey.currentState?.showSnackBar(snackbar);
      }
    } on FirebaseAuthException catch (e) {
      final snackbar = createSnackbar(
          'Error creating account', e.toString(), ContentType.failure);
      snackbarKey.currentState?.showSnackBar(snackbar);
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
        if (_user == null) {
          Get.offAll(() => LoginScreen());
        } else {
          Get.offAll(() => const HomeScreen());
        }
      } else {
        final snackbar = createSnackbar(
            'On Snap!', 'Please enter all the fields!', ContentType.warning);
        snackbarKey.currentState?.showSnackBar(snackbar);
        // Get.snackbar(
        //   'Error logging in',
        //   'Please enter all the fields',
        // );
      }
    } catch (e) {
      final snackbar =
          createSnackbar('Error logging in', e.toString(), ContentType.failure);
      snackbarKey.currentState?.showSnackBar(snackbar);
    }
  }

  void resetPassword(String text) async {
    try {
      if (text != '') {
        await firebaseAuth.sendPasswordResetEmail(email: text);
        Get.back();
        final snackbar = createSnackbar('Notice has been sent',
            'Please check your email!', ContentType.success);
        snackbarKey.currentState?.showSnackBar(snackbar);
      } else {
        final snackbar = createSnackbar('Error reseting password',
            'Please enter all the field', ContentType.warning);
        snackbarKey.currentState?.showSnackBar(snackbar);
      }
    } catch (e) {
      final snackbar = createSnackbar(
          'Error reseting password', e.toString(), ContentType.failure);
      snackbarKey.currentState?.showSnackBar(snackbar);
    }
  }

  // setInitialScreen(User? user) {
  //   if (user == null) {
  //     Get.offAll(() => LoginScreen());
  //   } else {
  //     Get.offAll(() => const HomeScreen());
  //   }
  // }
}
