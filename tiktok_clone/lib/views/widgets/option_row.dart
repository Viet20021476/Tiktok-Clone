import 'package:flutter/material.dart';

class OptionRow extends StatelessWidget {
  String title;
  String data;

  OptionRow({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 14,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
