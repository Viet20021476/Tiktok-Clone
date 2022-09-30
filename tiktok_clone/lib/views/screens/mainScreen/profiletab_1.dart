import 'package:flutter/material.dart';

class FirstTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 9,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              //height: 70,
              //width: 70,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://media0.giphy.com/media/huyZxIJvtqVeRp7QcS/giphy.gif?cid=ecf05e47cy72hanh2xk3dsewm7wdd3bzg96j73dm80j686sb&rid=giphy.gif&ct=g"),
                      fit: BoxFit.fill)),
            ),
          );
        });
  }
}
