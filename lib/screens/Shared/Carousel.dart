import 'package:animeze/screens/Details/CharacterDetails.dart';
import 'package:animeze/screens/Details/Details.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final List list;
  final double height;
  final double width;
  final bool toCharacterDetails;
  Carousel({this.list, this.height, this.width, this.toCharacterDetails});

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
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget.toCharacterDetails
                        ? CharacterDetails(
                            id: widget.list[index]['mal_id'],
                          )
                        : Details(
                            id: widget.list[index]['mal_id'],
                          ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Image.network(
                  widget.list[index]['image_url'],
                  fit: BoxFit.fill,
                  width: widget.width,
                ),
              ),
            );
          }),
    );
  }
}
