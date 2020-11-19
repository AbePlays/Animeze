import 'package:animeze/database/DatabaseHelper.dart';
import 'package:animeze/model/AnimeModel.dart';
import 'package:animeze/screens/Shared/Content.dart';
import 'package:animeze/screens/Shared/Header.dart';
import 'package:flutter/material.dart';

class FavoriteAnimes extends StatefulWidget {
  @override
  _FavoriteAnimesState createState() => _FavoriteAnimesState();
}

class _FavoriteAnimesState extends State<FavoriteAnimes> {
  final dbHelper = DatabaseHelper.instance;
  List<Anime> savedData = [];
  bool showMessage = true;

  getData() async {
    var length = await dbHelper.numberOfItems();
    if (length == 0) {
      setState(() {
        showMessage = true;
      });
    } else {
      var data = await dbHelper.queryAllRows();
      setState(
        () {
          showMessage = false;
          savedData = List.generate(
            data.length,
            (index) => Anime(
              id: data[index]['id'],
              imageUrl: data[index]['imageUrl'],
              title: data[index]['title'],
              score: data[index]['score'],
              dateReleased: data[index]['dateReleased'],
            ),
          );
        },
      );
    }
  }

  deleteItem(id) async {
    await dbHelper.delete(5114);
    getData();
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
        child: Container(
          padding: EdgeInsets.all(20),
          color: Colors.grey[200],
          child: Column(
            children: [
              Header(
                leftIconName: "arrow_back",
                title: "FAVORITES",
                rightIconName: "",
                isBackgroundOn: true,
              ),
              SizedBox(
                height: 20,
              ),
              showMessage
                  ? Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Text(
                        "No Favorites Found :(",
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: savedData.length,
                        itemBuilder: (BuildContext context, var index) {
                          // return Text(savedData[index].title);
                          return Content(
                            imageUrl: savedData[index].imageUrl,
                            title: savedData[index].title,
                            score: savedData[index].score,
                            startDate: savedData[index].dateReleased,
                          );
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
