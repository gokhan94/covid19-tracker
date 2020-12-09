import 'package:flutter/material.dart';
import 'package:ncov_app/model/country_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CountryChart extends StatelessWidget {

  final List<CountryData> data;
  CountryChart({@required this.data});

  @override
  Widget build(BuildContext context) {

    List<charts.Series<CountryData, String>> series = [
      charts.Series(
          id: "Country",
          data: data,
          domainFn: (CountryData series, _) => series.detail,
          measureFn: (CountryData series, _) => series.details,
          colorFn: (CountryData series, _) => series.barColor)
    ];

    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "World of Covid 19",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
