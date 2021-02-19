import 'package:animeze/model/AnimeModel.dart';
import 'package:animeze/provider/DataProvider.dart';
import 'package:animeze/screens/Details/Details.dart';
import 'package:animeze/screens/Shared/Content.dart';
import 'package:animeze/screens/Shared/Header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteAnimes extends StatefulWidget {
  @override
  _FavoriteAnimesState createState() => _FavoriteAnimesState();
}

class _FavoriteAnimesState extends State<FavoriteAnimes> {
  List<Anime> savedData = [];
  bool showMessage = true;

  getData() {
    int length =
        Provider.of<DataProvider>(context, listen: false).currentSize();
    if (length == 0) {
      setState(() {
        showMessage = true;
      });
    } else {
      setState(() {
        savedData = Provider.of<DataProvider>(context, listen: false).anime;
        showMessage = false;
      });
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
        child: Container(
          padding: EdgeInsets.all(20),
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Details(
                                    id: savedData[index].id,
                                    episodes: savedData[index]
                                        .numberOfEpisodes
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            child: Content(
                              imageUrl: savedData[index].imageUrl,
                              title: savedData[index].title,
                              score: savedData[index].score,
                              startDate: savedData[index].dateReleased,
                            ),
                          );
                          // return Content(
                          //   imageUrl: savedData[index].imageUrl,
                          //   title: savedData[index].title,
                          //   score: savedData[index].score,
                          //   startDate: savedData[index].dateReleased,
                          // );
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
