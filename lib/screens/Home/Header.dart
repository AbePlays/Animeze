import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        Text(
          "ANIMEZE",
          style: TextStyle(letterSpacing: 5, fontSize: 20),
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
        )
      ],
    );
  }
}
