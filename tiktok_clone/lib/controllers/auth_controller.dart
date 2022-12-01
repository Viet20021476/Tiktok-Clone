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

  late final Rx<File> _pickedImage = Rx<File>(file);
  late Rx<User?> _user;
  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  File get profilePhoto => _pickedImage.value;

  User get user => _user.value!;

  @override
  void onReady() async {
    super.onReady();
    await firebaseAuth.signOut();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    file = await imageToFile(imageName: 'images/avatar', ext: 'png');
    ever(_user, setInitialScreen);
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
  }

  //register the user
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        _isLoading.value = true;
        //save out user to auth and firebase firestore
        UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        String downloadURL = await uploadToStorage(image);
        models.User user = models.User(
            email: email,
            name: username,
            uid: userCredential.user!.uid,
            profilePhoto: downloadURL,
            tiktokID: '@${username}',
            bio: '');
        await firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(user.toJson());
        _isLoading.value = false;

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
      _isLoading.value = false;
      Get.back();

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
        _isLoading.value = true;

        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        _isLoading.value = false;
      } else {
        final snackbar = createSnackbar(
            'On Snap!', 'Please enter all the fields!', ContentType.warning);
        snackbarKey.currentState?.showSnackBar(snackbar);
        _isLoading.value = false;

        // Get.snackbar(
        //   'Error logging in',
        //   'Please enter all the fields',
        // );
      }
    } catch (e) {
      Get.back();

      _isLoading.value = false;

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

  void changePassword(String password) async {
    //Pass in the password to updatePassword.
    if (password.trim() == '') {
      final snackbar =
          createSnackbar('Please enter all the field', '', ContentType.warning);
      snackbarKey.currentState?.showSnackBar(snackbar);
      return;
    }
    user.updatePassword(password).then((_) {
      Get.back();
      final snackbar = createSnackbar(
          'Update password successfully', '', ContentType.success);
      snackbarKey.currentState?.showSnackBar(snackbar);
      print("Successfully changed password");
    }).catchError((error) {
      final snackbar =
          createSnackbar(error.toString(), '', ContentType.failure);
      snackbarKey.currentState?.showSnackBar(snackbar);
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

  setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }
}
