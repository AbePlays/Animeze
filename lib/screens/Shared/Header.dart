import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  final String leftIconName;
  final String title;
  final String rightIconName;
  final bool isBackgroundOn;
  Header(
      {this.leftIconName, this.title, this.rightIconName, this.isBackgroundOn});

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
          backgroundColor:
              widget.isBackgroundOn ? Colors.grey[200] : Colors.transparent,
          child: Text(
            widget.leftIconName,
            style: TextStyle(
                fontFamily: 'MaterialIcons',
                fontSize: 25,
                color: widget.isBackgroundOn ? Colors.black : Colors.white),
          ),
        ),
        widget.title.isNotEmpty
            ? Text(
                widget.title,
                style: TextStyle(letterSpacing: 5, fontSize: 20),
              )
            : SizedBox.shrink(),
        widget.rightIconName.isNotEmpty
            ? CircleAvatar(
                backgroundColor: widget.isBackgroundOn
                    ? Colors.grey[200]
                    : Colors.transparent,
                child: Text(
                  widget.rightIconName,
                  style: TextStyle(
                      fontFamily: 'MaterialIcons',
                      fontSize: 25,
                      color:
                          widget.isBackgroundOn ? Colors.black : Colors.white),
                ),
              )
            : CircleAvatar(
                backgroundColor: Colors.transparent,
              )
      ],
    );
  }
}
