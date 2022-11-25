import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var passwordController = TextEditingController();

  bool obcuseText = true;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            Get.back();
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: height * 0.15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: ListView(
              children: [
                SizedBox(height: height * 0.08),
                Text(
                  'reset password'.toUpperCase(),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Center(
                  child: Container(
                    height: 1,
                    width: width * 0.8,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: height * 0.15,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: TextFormField(
                    controller: passwordController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(30),
                    ],
                    obscureText: obcuseText,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            obcuseText = !obcuseText;
                          });
                        },
                        child: Icon(obcuseText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      isDense: true,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.08,
                ),
                InkWell(
                  onTap: () {
                    authController.changePassword(passwordController.text);
                  },
                  child: Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                      decoration: BoxDecoration(
                          gradient: new LinearGradient(colors: [
                            Colors.blue,
                            Color.fromARGB(255, 127, 133, 138)
                          ]),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                color: Colors.blue,
                                offset: Offset(2, 2))
                          ]),
                      child: Text(
                        "Update".toUpperCase(),
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.7),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
