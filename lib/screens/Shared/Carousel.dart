import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final List list;
  Carousel({this.list});

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
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
