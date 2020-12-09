import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ncov_app/data/network.dart';
import 'package:ncov_app/model/CoronaNews.dart';
import 'package:url_launcher/url_launcher.dart';

class CovidNews extends StatefulWidget {
  @override
  _CovidNewsState createState() => _CovidNewsState();
}

class _CovidNewsState extends State<CovidNews> {
  Future<CoronaNews> coronaNews;

  @override
  void initState() {
    super.initState();
    _getNewsData();
  }

  Future<CoronaNews> _getNewsData() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=tr&category=health&apiKey=0c34585a2be54b6bbf638ff960c3808a";
    Network network = Network(url);
    coronaNews = network.newsFetchData();
    return coronaNews;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo.shade300,
        appBar: AppBar(
            title: Text("Corona News"), backgroundColor: Colors.indigo.shade700),
        body: FutureBuilder<CoronaNews>(
          future: _getNewsData(),
          builder: (BuildContext context, AsyncSnapshot<CoronaNews> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        launch(snapshot.data.articles[index].url);
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.blue, Colors.indigo],
                                  tileMode: TileMode.repeated,
                                ),
                                color: Colors.indigo.shade800,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                border: Border.all(color: Colors.indigo.shade300),
                              ),
                              child: ListTile(
                                title: Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      snapshot.data.articles[index].title,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                                subtitle: Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      snapshot.data.articles[index].description,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white54),
                                    )),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(snapshot.data.articles[index].publishedAt,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white70)),
                                Container(
                                    margin: EdgeInsets.only(top: 5),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade800,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    child: Text(
                                        snapshot.data.articles[index].author != null ? snapshot.data.articles[index].author : "Author Null",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white70))
                                ),
                              ],
                            )
                          ],
                        ),
                      ));
                },
                itemCount: snapshot.data.articles.length,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
