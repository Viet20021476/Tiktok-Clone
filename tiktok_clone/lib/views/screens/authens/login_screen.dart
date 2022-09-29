import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/views/screens/authens/register_screen.dart';
import 'package:tiktok_clone/views/screens/mainScreen/home_screen.dart';
import 'package:tiktok_clone/views/screens/mainScreen/messages_screen.dart';
import 'package:tiktok_clone/views/widgets/text_input_field.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String login = 'Login';
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
          child: Container(
        child: Column(children: <Widget>[
          Container(
            height: 300,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
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
                  margin: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text(
                      login,
                      style: TextStyle(
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
            padding: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(143, 148, 251, .2),
                            blurRadius: 20,
                            offset: Offset(0, 10)),
                      ]),
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 255, 244, 244)))),
                      child: TextInputField(
                        controller: emailController,
                        icon: Icons.email,
                        labelText: 'Email',
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color.fromARGB(255, 240, 234, 234)))),
                      child: TextInputField(
                        controller: passwordController,
                        icon: Icons.lock,
                        labelText: 'Password',
                      ),
                    )
                  ]),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        Color.fromRGBO(143, 148, 251, 1),
                        Color.fromRGBO(143, 148, 251, .6),
                      ]),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Color.fromRGBO(143, 148, 251, 1),
                        ),
                      ),
                      onTap: () {
                        Get.to(() => RegisterScreen());
                        // Navigator.of(context).pop();
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => RegisterScreen()));
                      },
                    ),
                    InkWell(
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Color.fromRGBO(143, 148, 251, 1),
                        ),
                      ),
                      onTap: () {},
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
