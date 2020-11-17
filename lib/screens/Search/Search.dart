import 'package:animeze/screens/Details/Details.dart';
import 'package:animeze/screens/Shared/Content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Search extends StatefulWidget {
  final String query;
  Search({this.query});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchText;
  List results = [];

  handleSearch(String text) async {
    var url = 'https://api.jikan.moe/v3/search/anime?q=$text';
    try {
      var response = await http.get(url);
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        results = jsonResponse['results'];
        searchText = "";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey[200],
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Hero(
                  tag: 'search',
                  child: Material(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      onEditingComplete: () {
                        handleSearch(searchText);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, var index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Details(
                                  id: results[index]['mal_id'],
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
                      itemCount: results.isEmpty ? 0 : 10),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
