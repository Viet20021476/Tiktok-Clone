import 'package:flutter/material.dart';

import 'main.dart';

var number = 0;

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 200,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Hello How old are y'),
              ),
              MaterialButton(
                color: Colors.blue,
                child: Text('Post'),
                onPressed: () {},
              )
            ],
          ),
        ));
  }
}
