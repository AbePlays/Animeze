import 'package:animeze/screens/Details/CharacterDetails.dart';
import 'package:animeze/screens/Details/Details.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final List list;
  final double height;
  final double width;
  final bool toCharacterDetails;
  final bool shouldLimit;
  Carousel(
      {this.list,
      this.height,
      this.width,
      this.toCharacterDetails,
      this.shouldLimit});

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
          itemCount: widget.shouldLimit
              ? (widget.list.length > 5 ? 5 : widget.list.length)
              : widget.list.length,
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
                            episodes: widget.list[index]['episodes'].toString(),
                          ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: widget.list[index]['image_url'],
                  fit: BoxFit.fill,
                  width: widget.width,
                ),
              ),
            );
          }),
    );
  }
}
