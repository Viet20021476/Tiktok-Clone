import 'package:flutter/material.dart';
import 'FirstPage.dart';
import 'SecondPage.dart';
import 'ThirdPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('My app'),
      ),
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
                'Page 1',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => FirstPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'Page 2',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SecondPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'Page 3',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ThirdPage()));
              },
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        children: [
          for (var i = 0; i < 51; i++)
            Container(
              color: Colors.redAccent,
              child: Image.network('https://picsum.photos/250?image=9'),
            ),
        ],
      ),
    );
  }
}
