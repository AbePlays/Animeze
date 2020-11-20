import 'package:animeze/database/DatabaseHelper.dart';
import 'package:animeze/model/AnimeModel.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  List<Anime> anime = [];
  final dbHelper = DatabaseHelper.instance;

  List<Anime> get currentAnimeIds => anime;

  void initProviderData() async {
    var data = await dbHelper.queryAllRows();
    anime = List.generate(
      data.length,
      (index) => Anime(
        id: data[index]['id'],
        imageUrl: data[index]['imageUrl'],
        title: data[index]['title'],
        score: data[index]['score'],
        dateReleased: data[index]['dateReleased'],
      ),
    );
    print("data loaded!");
  }

  void insertToDb(Anime anime) async {
    try {
      await dbHelper.insert(anime.toMap());
      this.anime.add(anime);
    } catch (e) {
      print(e);
    }
  }

  int currentSize() {
    return anime.length;
  }

  void deleteFromDb(int id) async {
    try {
      await dbHelper.delete(id);
    } catch (e) {
      print(e);
    }
  }
}
