import 'package:animeze/screens/Home/Header.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Details extends StatefulWidget {
  final int id;
  Details({this.id});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String imageUrl;

  getData() async {
    var url = 'https://api.jikan.moe/v3/anime/${widget.id}';
    try {
      var response = await http.get(url);
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        imageUrl = jsonResponse['image_url'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.network(
                'https://cdn.myanimelist.net/images/anime/3/40451.jpg',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
                color: Color.fromRGBO(255, 255, 255, 0.5),
                colorBlendMode: BlendMode.modulate),
            Positioned(
                width: MediaQuery.of(context).size.width,
                top: 50,
                child: Header()),
            Positioned(
                top: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: ListView(
                      children: [],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
