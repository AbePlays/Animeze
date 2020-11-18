import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final List list;
  final double height;
  Carousel({this.list, this.height});

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: ListView.separated(
          separatorBuilder: (BuildContext context, var index) {
            return SizedBox(
              width: 30,
            );
          },
          scrollDirection: Axis.horizontal,
          itemCount: widget.list.isEmpty ? 0 : 5,
          itemBuilder: (BuildContext context, var index) {
            return ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Image.network(widget.list[index]['image_url']),
            );
          }),
    );
  }
}
