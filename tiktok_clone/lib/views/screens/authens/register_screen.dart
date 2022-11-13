import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String register = 'Register';
    return Obx(() {
      return Scaffold(
        key: const Key('register-screen'),
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
                      top: 30,
                      right: 20,
                      child: Center(
                        child: Text(
                          register,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Positioned(
                    top: 172,
                    left: MediaQuery.of(context).size.width / 2 - 64,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 64,
                          backgroundImage:
                              FileImage(authController.profilePhoto),
                        ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: () => authController.pickImage(),
                            icon: const Icon(
                              Icons.add_a_photo,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                                    color:
                                        Color.fromARGB(255, 255, 244, 244)))),
                        child: TextInputField(
                          controller: userNameController,
                          icon: Icons.person,
                          labelText: 'Username',
                          isObscure: false,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color:
                                        Color.fromARGB(255, 255, 244, 244)))),
                        child: TextInputField(
                          controller: emailController,
                          icon: Icons.email,
                          labelText: 'Email',
                          isObscure: false,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color:
                                        Color.fromARGB(255, 255, 244, 244)))),
                        child: TextInputField(
                          controller: passwordController,
                          icon: Icons.lock,
                          labelText: 'Password',
                          isObscure: true,
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      authController.registerUser(
                          userNameController.text,
                          emailController.text,
                          passwordController.text,
                          authController.profilePhoto);
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
                        child: Text(
                          "Register",
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
                          Navigator.of(context).pop();
                        },
                      ),
                      InkWell(
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Color.fromRGBO(143, 148, 251, 1),
                          ),
                        ),
                        onTap: () {
                          print(authController.profilePhoto);
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
    });
  }
}
