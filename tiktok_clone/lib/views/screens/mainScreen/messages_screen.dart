import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black12))),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 20,
                    ),
                    Row(
                      children: const [
                        Text(
                          "All activity",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                    const ImageIcon(
                        AssetImage('assets/my-icons/vector3stroke.png'))
                  ],
                ),
              ),
              const SizedBox(
                height: 250,
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ImageIcon(
                    AssetImage('assets/my-icons/messageicon.png'),
                    size: 80,
                    color: Colors.black45,
                  )
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                "All activity",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
              const SizedBox(height: 3),
              const Text(

                "Notifications about your account will appear here",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
