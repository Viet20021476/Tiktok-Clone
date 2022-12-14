import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/screens/authens/login_screen.dart';
import 'package:tiktok_clone/views/screens/authens/register_screen.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String reset = 'Reset';
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          // ignore: avoid_unnecessary_containers
          child: Container(
        child: Column(children: <Widget>[
          Container(
            height: 300,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/login_background.png'),
              fit: BoxFit.fill,
            )),
            child: Stack(
              children: [
                Positioned(
                  left: 30,
                  width: 80,
                  height: 200,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/light-1.png'),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 140,
                  width: 80,
                  height: 150,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/light-2.png'),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 40,
                  width: 80,
                  height: 150,
                  top: 40,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/clock.png'),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    child: Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      reset,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            blurRadius: 20,
                            offset: Offset(0, 10)),
                      ]),
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 255, 244, 244)))),
                      child: TextInputField(
                        controller: emailController,
                        icon: Icons.email,
                        labelText: 'Email',
                        isObscure: false,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    authController.resetPassword(emailController.text.trim());
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(colors: [
                        Color.fromRGBO(143, 148, 251, 1),
                        Color.fromRGBO(143, 148, 251, .6),
                      ]),
                    ),
                    child: const Center(
                      key: Key("Reset password"),
                      child: Text(
                        "Reset password",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color.fromRGBO(143, 148, 251, 1),
                        ),
                      ),
                      onTap: () {
                        Get.off(LoginScreen());
                        // Navigator.of(context).pop();
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => RegisterScreen()));
                      },
                    ),
                    InkWell(
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Color.fromRGBO(143, 148, 251, 1),
                        ),
                      ),
                      onTap: () {
                        Get.off(const RegisterScreen());
                        // if (Get.currentRoute )
                      },
                    ),
                  ],
                )
              ],
            ),
          )
        ]),
      )),
    );
  }
}
