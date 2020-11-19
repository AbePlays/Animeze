import 'package:flutter/material.dart';

class FavoriteAnimes extends StatefulWidget {
  @override
  _FavoriteAnimesState createState() => _FavoriteAnimesState();
}

class _FavoriteAnimesState extends State<FavoriteAnimes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Favs"),
      ),
    );
  }
}
