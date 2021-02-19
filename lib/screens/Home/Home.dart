import 'package:animeze/provider/DataProvider.dart';
import 'package:animeze/provider/ThemeProvider.dart';
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

  var outlineBorder;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: Colors.transparent),
    );

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black : Colors.grey[200],
              ),
              child: Center(
                child: Text(
                  'ANIMEZE',
                  style: TextStyle(
                    letterSpacing: 5,
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
              title: Text("Dark Mode"),
              trailing: ThemeWidget(),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                buildSearch(context, isDarkMode),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Top Animes',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "More",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "More",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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

  Hero buildSearch(BuildContext context, bool isDarkMode) {
    return Hero(
      tag: 'search',
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
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

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch(
        value: themeProvider.isDarkMode,
        onChanged: (val) {
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(val);
        });
  }
}
