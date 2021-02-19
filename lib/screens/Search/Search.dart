import 'package:animeze/provider/ThemeProvider.dart';
import 'package:animeze/screens/Shared/Header.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animeze/screens/Details/Details.dart';
import 'package:animeze/screens/Shared/Content.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  final String query;
  Search({this.query});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading;
  String searchText = "";
  List results = [];

  handleSearch(String text) async {
    setState(() {
      isLoading = true;
    });
    var url = 'https://api.jikan.moe/v3/search/anime?q=$text';
    try {
      var response = await http.get(url);
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        results = jsonResponse['results'];
        searchText = "";
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    handleSearch(widget.query);
  }

  var outlineBorder;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: Colors.transparent),
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              Header(
                leftIconName: "arrow_back",
                title: "ANIMEZE",
                rightIconName: "",
                isBackgroundOn: true,
              ),
              SizedBox(
                height: 20,
              ),
              buildSearch(context, isDarkMode),
              SizedBox(
                height: 15,
              ),
              isLoading
                  ? SpinKitThreeBounce(
                      color: Theme.of(context).primaryColor,
                      size: 25.0,
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, var index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Details(
                                    id: results[index]['mal_id'],
                                    episodes:
                                        results[index]['episodes'].toString(),
                                  ),
                                ),
                              );
                            },
                            child: Content(
                              imageUrl: results[index]['image_url'],
                              score: results[index]['score'],
                              startDate: results[index]['start_date'],
                              title: results[index]['title'],
                            ),
                          );
                        },
                        itemCount: results.isEmpty ? 0 : 10,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Hero buildSearch(BuildContext context, bool isDarkMode) {
    return Hero(
      tag: 'search',
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: TextField(
          textCapitalization: TextCapitalization.words,
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
          onEditingComplete: () {
            handleSearch(searchText);
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            prefixIcon: Icon(
              Icons.search,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            filled: true,
            hintText: "Search",
            border: outlineBorder,
            enabledBorder: outlineBorder,
            focusedBorder: outlineBorder,
          ),
        ),
      ),
    );
  }
}
