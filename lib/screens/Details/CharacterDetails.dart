import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CharacterDetails extends StatefulWidget {
  final int id;
  CharacterDetails({this.id});

  @override
  _CharacterDetailsState createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  List names = [];
  var data;

  getData() async {
    var url = 'https://api.jikan.moe/v3/character/${widget.id}';
    try {
      var response = await http.get(url);
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        data = jsonResponse;
        names = data['nicknames'];
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("${data['image_url']}"),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  data['name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Nicknames",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                              label: Text(e),
                            ),
                          )
                          .toList(),
                    )
                  : Text(
                      "N/A",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
              SizedBox(
                height: 10,
              ),
              Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                data['about'].replaceAll("\\n", "\n"),
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
