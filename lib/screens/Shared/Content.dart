import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String startDate;
  final num score;

  Content({this.imageUrl, this.title, this.score, this.startDate});

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 2,
              child: Container(
                width: MediaQuery.of(context).size.width * .9,
                height: 150,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    width: MediaQuery.of(context).size.width * .9 - 150,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Score : ${widget.score.toString()}",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Date Released : ${widget.startDate?.isEmpty ?? true ? 'N/A' : widget.startDate.substring(0, 10)}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 30,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  fit: BoxFit.cover,
                  image: widget.imageUrl,
                  height: 150,
                  width: 100,
                )),
          ),
        ],
      ),
    );
  }
}
