import 'dart:io';
import 'package:get/get.dart';

class AuthController extends GetX {
  AuthController({required super.builder});

  //register the user
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //save out user to auth and firebase firestore
      }
    } catch (e) {
      Get.snackbar('Error creating acount', e.toString());
    }
  }
}
