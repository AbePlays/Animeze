import 'package:animeze/screens/Shared/Header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CharacterDetails extends StatefulWidget {
  final int id;
  CharacterDetails({this.id});

  @override
  _CharacterDetailsState createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  bool isLoading;
  List names = [];
  var data;

  getData() async {
    isLoading = true;
    var url = 'https://api.jikan.moe/v3/character/${widget.id}';
    try {
      var response = await http.get(url);
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        data = jsonResponse;
        names = data['nicknames'];
        isLoading = false;
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
      body: SafeArea(
        child: isLoading
            ? Center(
                child: SpinKitThreeBounce(
                  color: Theme.of(context).primaryColor,
                  size: 25.0,
                ),
              )
            : Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Header(
                      leftIconName: 'arrow_back',
                      title: "DETAILS",
                      rightIconName: "favorite_border",
                      isBackgroundOn: true,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(0),
                        children: [
                          Center(
                            child: Avatar(data: data),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Text(
                              data['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Nicknames",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          names.length > 0
                              ? Wrap(
                                  spacing: 5,
                                  children: names
                                      .map(
                                        (e) => Chip(
                                          label: Text(
                                            e,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                )
                              : Text(
                                  "N/A",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "About",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            (data['about'].replaceAll("\\n", "\n"))
                                .replaceAll('\n\r\n\n\r', '\n'),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    Key key,
    @required this.data,
  }) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(110),
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(105),
            child: Container(
              color: Theme.of(context).accentColor,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/placeholder.png',
                      image: data['image_url'],
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
