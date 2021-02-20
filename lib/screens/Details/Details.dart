import 'package:animeze/database/DatabaseHelper.dart';
import 'package:animeze/provider/DataProvider.dart';
import 'package:animeze/screens/Shared/Header.dart';
import 'package:animeze/screens/Shared/Carousel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animeze/model/AnimeModel.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final int id;
  final String episodes;
  Details({this.id, this.episodes});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Anime anime;
  bool isFav = false;
  bool isLoading;
  Map data;
  String imageUrl;
  List characters = [];

  final dbHelper = DatabaseHelper.instance;
  final globalKey = GlobalKey<ScaffoldState>();

  toggleSnackBar(String message, Color bgColor) {
    final sb = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: bgColor,
    );
    globalKey.currentState.showSnackBar(sb);
  }

  saveToDatabase() {
    Provider.of<DataProvider>(context, listen: false).insertToDb(anime);
    setState(() {
      isFav = true;
    });
    toggleSnackBar("Added to Favorites", Colors.green);
  }

  deleteFromDatabase() {
    Provider.of<DataProvider>(context, listen: false).deleteFromDb(anime.id);
    setState(() {
      isFav = false;
    });
    toggleSnackBar("Removed from Favorites", Colors.red);
  }

  getData() async {
    isLoading = true;
    var url = 'https://api.jikan.moe/v3/anime/${widget.id}';
    try {
      var response = await http.get(url);
      var jsonResponse = convert.jsonDecode(response.body);

      List<Anime> animeList =
          Provider.of<DataProvider>(context, listen: false).anime;

      setState(() {
        data = jsonResponse;

        anime = new Anime(
          id: widget.id,
          imageUrl: data['image_url'],
          title: data['title'],
          score: data['score'],
          dateReleased: data['aired']['from'].toString().substring(0, 10),
          numberOfEpisodes: int.parse(widget.episodes),
        );

        for (var item in animeList) {
          if (item.id == anime.id) {
            isFav = true;
            break;
          }
        }

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
      key: globalKey,
      body: SafeArea(
        top: false,
        child: isLoading
            ? Center(
                child: SpinKitThreeBounce(
                  color: Theme.of(context).primaryColor,
                  size: 25.0,
                ),
              )
            : Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Image.network(
                      data['image_url'],
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.contain,
                      color: Color.fromRGBO(255, 255, 255, 0.3),
                      colorBlendMode: BlendMode.modulate,
                    ),
                    Positioned(
                      width: MediaQuery.of(context).size.width - 40,
                      top: 50,
                      left: 20,
                      child: Header(
                        leftIconName: "arrow_back",
                        title: "",
                        rightIconName: isFav ? "favorite" : "favorite_border",
                        isBackgroundOn: false,
                        callbackFunction:
                            isFav ? deleteFromDatabase : saveToDatabase,
                      ),
                    ),
                    TweenAnimationBuilder(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 200,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                            buildContent(context),
                          ],
                        ),
                      ),
                      tween: Tween<double>(
                          begin: MediaQuery.of(context).size.height / 2,
                          end: 200),
                      duration: Duration(milliseconds: 600),
                      builder:
                          (BuildContext context, double val, Widget child) {
                        return Positioned(
                          top: val,
                          child: Opacity(
                            opacity: 200 / val,
                            child: child,
                          ),
                        );
                      },
                    ),
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
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/placeholder.png',
            image: data['image_url'],
            width: MediaQuery.of(context).size.width / 3,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: ListView(
              padding: EdgeInsets.only(top: 5),
              children: [
                Text(
                  data['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  data['score'].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w900,
                    fontSize: 25,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Table(
                  children: [
                    TableRow(
                      children: [
                        Text(
                          'Length',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Airing',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Type',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Episodes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
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
                      ],
                    ),
                    TableRow(
                      children: [
                        Text(
                          data['duration'].toString().replaceAll('per', '/'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          data['airing'] ? "Yes" : "No",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          data['type'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          widget.episodes,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Storyline",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  data['synopsis'],
                  style: TextStyle(fontSize: 13, height: 2),
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
