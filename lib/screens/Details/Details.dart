import 'package:animeze/database/DatabaseHelper.dart';
import 'package:animeze/screens/Shared/Header.dart';
import 'package:animeze/screens/Shared/Carousel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animeze/model/AnimeModel.dart';

class Details extends StatefulWidget {
  final int id;
  final String episodes;
  Details({this.id, this.episodes});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Anime anime;
  bool isLoading;
  Map data;
  String imageUrl;
  List characters = [];

  final dbHelper = DatabaseHelper.instance;

  saveToDatabase() async {
    try {
      await dbHelper.insert(anime.toMap());
    } catch (e) {
      print(e);
    }
  }

  getData() async {
    isLoading = true;
    var url = 'https://api.jikan.moe/v3/anime/${widget.id}';
    try {
      var response = await http.get(url);
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        data = jsonResponse;
        anime = new Anime(
            id: widget.id,
            imageUrl: data['image_url'],
            title: data['title'],
            score: data['score'],
            dateReleased: data['aired']['from'].toString().substring(0, 10));
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  getCharacters() async {
    var url = 'https://api.jikan.moe/v3/anime/${widget.id}/characters_staff';
    try {
      var response = await http.get(url);
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        characters = jsonResponse['characters'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: isLoading
            ? Center(
                child: SpinKitThreeBounce(
                  color: Colors.black,
                  size: 25.0,
                ),
              )
            : Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Image.network(data['image_url'],
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                        color: Color.fromRGBO(255, 255, 255, 0.3),
                        colorBlendMode: BlendMode.modulate),
                    Positioned(
                        width: MediaQuery.of(context).size.width - 40,
                        top: 50,
                        left: 20,
                        child: Header(
                          leftIconName: "arrow_back",
                          title: "",
                          rightIconName: "favorite_border",
                          isBackgroundOn: false,
                          callbackFunction: saveToDatabase,
                        )),
                    Positioned(
                      top: 200,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 200,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            buildContent(context),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Column buildContent(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.png',
              image: data['image_url'],
              width: MediaQuery.of(context).size.width / 3,
            )),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                Text(
                  data['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1,
                    fontWeight: FontWeight.w700,
                    fontSize: 35,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  data['score'].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w900,
                      fontSize: 40,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                Table(
                  children: [
                    TableRow(children: [
                      Text(
                        'Length',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Airing',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Type',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Episodes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                    TableRow(children: [
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ]),
                    TableRow(children: [
                      Text(
                        data['duration'].toString().replaceAll('per', '/'),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data['airing'] ? "Yes" : "No",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data['type'],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.episodes,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ])
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Storyline",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  data['synopsis'],
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Characters",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Carousel(
                  list: characters,
                  height: 200,
                  width: 130,
                  toCharacterDetails: true,
                  shouldLimit: false,
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
