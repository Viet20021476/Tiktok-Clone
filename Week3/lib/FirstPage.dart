import 'package:flutter/material.dart';

import 'SecondPage.dart';
import 'main.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  child: const Center(
                child: Text('LOGO'),
              )),
              ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  'Home Page',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => MyHome()));
                },
              ),
            ],
          ),
        ),
        body: ListView(
          children: [
            Container(
              color: Colors.green,
              height: 300,
              child: Image.network('https://picsum.photos/250?image=9'),
            ),
            Container(
              height: 300,
              child: Image.network('https://picsum.photos/250?image=9'),
            ),
            Container(
              color: Colors.green,
              height: 300,
              child: Image.network('https://picsum.photos/250?image=9'),
            ),
            Container(
              height: 300,
              child: Image.network('https://picsum.photos/250?image=9'),
            ),
            Container(
              color: Colors.green,
              height: 300,
              child: Image.network('https://picsum.photos/250?image=9'),
            )
          ],
        ));
  }
}
