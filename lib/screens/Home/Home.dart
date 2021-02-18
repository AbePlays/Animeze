import 'package:animeze/provider/DataProvider.dart';
import 'package:animeze/screens/Favorites/FavoriteAnimes.dart';
import 'package:animeze/screens/Search/Search.dart';
import 'package:animeze/screens/Shared/Carousel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:animeze/screens/Shared/Header.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String query;
  List topAnimes = [];
  List topAiringAnimes = [];

  getTopAnimes() async {
    var url = 'https://api.jikan.moe/v3/top/anime/1/favorite';
    try {
      var response = await http.get(url);
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        topAnimes = jsonResponse['top'];
      });
    } catch (e) {
      print(e);
    }
  }

  getTopAiringAnimes() async {
    var url = 'https://api.jikan.moe/v3/top/anime/1/airing';
    try {
      var response = await http.get(url);
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        topAiringAnimes = jsonResponse['top'];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(context, listen: false).initProviderData();
    getTopAnimes();
    getTopAiringAnimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Center(
                child: Text(
                  'ANIMEZE',
                  style: TextStyle(
                    letterSpacing: 5,
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoriteAnimes()),
                );
              },
              child: ListTile(
                leading: Icon(Icons.stars),
                title: Text("Favorite Animes"),
              ),
            ),
            Divider(
              height: 0,
              indent: 15,
              endIndent: 15,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("App Settings"),
            ),
            Divider(
              height: 0,
              indent: 15,
              endIndent: 15,
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Help & Support"),
            ),
            Divider(
              height: 0,
              indent: 15,
              endIndent: 15,
            ),
            ListTile(
              leading: Icon(Icons.wb_sunny),
              title: Text("Turn On Dark Mode"),
              trailing: Switch(value: false, onChanged: null),
            ),
            Divider(
              height: 0,
              indent: 15,
              endIndent: 15,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                  leftIconName: "menu",
                  title: "ANIMEZE",
                  rightIconName: "",
                  isBackgroundOn: true,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Find Anime, Manga\nand more...",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                buildSearch(context),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Top Animes',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "More",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Carousel(
                  list: topAnimes,
                  height: 300,
                  width: 200,
                  toCharacterDetails: false,
                  shouldLimit: true,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Top Airing Animes',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "More",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Carousel(
                  list: topAiringAnimes,
                  height: 300,
                  width: 200,
                  toCharacterDetails: false,
                  shouldLimit: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Hero buildSearch(BuildContext context) {
    return Hero(
      tag: 'search',
      child: Material(
        child: TextField(
          textCapitalization: TextCapitalization.words,
          onChanged: (value) {
            setState(() {
              query = value;
            });
          },
          onEditingComplete: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Search(
                  query: query,
                ),
              ),
            );
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            filled: true,
            fillColor: Colors.grey[200],
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
    );
  }
}
