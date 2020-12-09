import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ncov_app/data/network.dart';
import 'package:ncov_app/utils/const.dart';
import 'package:ncov_app/model/Country.dart';
import 'country_global_chart.dart';
import 'package:intl/intl.dart';
import 'package:ncov_app/model/country_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GlobalScreen extends StatefulWidget {
  @override
  _GlobalScreenState createState() => _GlobalScreenState();
}

class _GlobalScreenState extends State<GlobalScreen> {
  final Country countryData;
  _GlobalScreenState({this.countryData});

  final formatData = NumberFormat.compact(locale: "en");

  Future data;

  @override
  void initState() {
    super.initState();
    _getGlobalData();
  }

  Future _getGlobalData() async {
    String url =
        "https://disease.sh/v3/covid-19/all?yesterday=0&twoDaysAgo=0&allowNull=0";
    Network network = Network(url);

    data = network.globalFetchData();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo.shade800,
        body: FutureBuilder(
          future: _getGlobalData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    child: Image.asset("assets/images/virus2.png"),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAppBar(context),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Global Statistic",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 32),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _buildStatistic(context, snapshot.data),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildTodayDeaths(
                                    context, "Today Deaths", snapshot.data),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                // today cases
                                child: _buildTodayCases(
                                    context, "Today Cases", snapshot.data),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: RichText(
                            text: TextSpan(
                                text: "Global Cases of ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.blueGrey),
                                children: [
                                  TextSpan(
                                      text: "COVID 19",
                                      style:
                                          TextStyle(color: AppColors.mainColor))
                                ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildCritical(
                                    context, "Critical", snapshot.data),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: _buildTotalActive(
                                    context, "Total Active", snapshot.data),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white70,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Container(
          margin: EdgeInsets.all(15),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(100))),
        )
      ],
    );
  }

  _buildStatistics(
      BuildContext context, Color color, String title, String number) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          Icons.label,
          size: 50,
          color: color,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.black87, fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              number,
              style: TextStyle(fontSize: 18),
            )
          ],
        )
      ],
    );
  }

  _buildStatistic(BuildContext context, Map<String, dynamic> data) {
    final List<CountryData> dataCountry = [
      CountryData(
        detail: "Cases",
        details: data['cases'],
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      ),
      CountryData(
        detail: "Recovered",
        details: data['recovered'],
        barColor: charts.ColorUtil.fromDartColor(Colors.yellowAccent),
      ),
      CountryData(
        detail: "Deaths",
        details: data['deaths'],
        barColor: charts.ColorUtil.fromDartColor(Colors.redAccent),
      ),
    ];

    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(1, 1),
                spreadRadius: 1,
                blurRadius: 3)
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 15),
        padding: EdgeInsets.all(25),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 150,
                  height: 150,
                  child: CountryGlobalChart(data: dataCountry)),
              SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatistics(context, Colors.blueAccent, "Cases",
                      data['cases'].toString()),
                  _buildStatistics(context, Colors.yellowAccent, "Recovered",
                      data['recovered'].toString()),
                  _buildStatistics(context, Colors.redAccent, "Deaths",
                      data['deaths'].toString()),
                ],
              ),
            ],
          ),
        ));
  }

  _buildTodayCases(
      BuildContext context, String text, Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.indigo.shade300,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(color: Colors.indigo.shade400),
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              offset: Offset(4, 5),
              spreadRadius: 3,
              blurRadius: 2)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.timeline,
                size: 35,
                color: Colors.indigo,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade900,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            formatData.format(data['todayCases']),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  _buildTodayDeaths(
      BuildContext context, String text, Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.indigo.shade300,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(color: Colors.indigo.shade400),
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              offset: Offset(4, 5),
              spreadRadius: 3,
              blurRadius: 2)
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.timeline,
                size: 35,
                color: Colors.indigo,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade900,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            formatData.format(data['todayDeaths']),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  _buildTotalActive(
      BuildContext context, String text, Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.indigo.shade300,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(color: Colors.indigo.shade400),
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              offset: Offset(4, 5),
              spreadRadius: 3,
              blurRadius: 2)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.timeline,
                size: 35,
                color: Colors.indigo,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade900,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            formatData.format(data['active']),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  _buildCritical(BuildContext context, String text, Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.indigo.shade300,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(color: Colors.indigo.shade400),
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              offset: Offset(4, 5),
              spreadRadius: 3,
              blurRadius: 2)
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.timeline,
                size: 35,
                color: Colors.indigo,
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade900,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            formatData.format(data['critical']),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
