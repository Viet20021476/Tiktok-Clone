import 'package:flutter/material.dart';

import 'main.dart';

double number = 0;

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          Container(
            height: 300,
          ),
          Text(
            number.toString(),
            style: TextStyle(fontSize: 30),
          ),
          Slider(
              value: number,
              min: 0,
              max: 10,
              divisions: 10,
              onChanged: (value) {
                setState(() {
                  number = value;
                });
              })
        ],
      ),
    );
  }
}
