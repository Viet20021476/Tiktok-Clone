import 'package:flutter/material.dart';

class SecondTab extends StatelessWidget {
  const SecondTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 9,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              //height: 70,
              //width: 70,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://media4.giphy.com/media/VbnUQpnihPSIgIXuZv/giphy.gif?cid=ecf05e47mjzmg73w0rcld82f7yejv8w5xzeducpntdztmz4w&rid=giphy.gif&ct=g"),
                      fit: BoxFit.fill)),
            ),
          );
        });
  }
}
