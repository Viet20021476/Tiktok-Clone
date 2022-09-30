import 'package:flutter/material.dart';

class ThirdTab extends StatelessWidget {

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
                          "https://media0.giphy.com/media/l3vQXKPdzpShJtTCE/giphy.gif?cid=ecf05e47zrz9uq0c9haqm8ud31pj78kd4jg0rq5fwa7xh24t&rid=giphy.gif&ct=g"),
                      fit: BoxFit.fill)),
            ),
          );
        });
  }
}