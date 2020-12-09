import 'package:flutter/material.dart';
import 'package:ncov_app/model/country_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CountryGlobalChart extends StatelessWidget {
  final List<CountryData> data;
  CountryGlobalChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<CountryData, String>> series = [
      charts.Series(
          id: "Global Country",
          data: data,
          domainFn: (CountryData series, _) => series.detail,
          measureFn: (CountryData series, _) => series.details,
          colorFn: (CountryData series, _) => series.barColor)
    ];

    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
              child: charts.PieChart(series,
                  animate: true,

                  defaultRenderer: new charts.ArcRendererConfig(arcWidth: 30),))
        ],
      ),
    );
  }
}
