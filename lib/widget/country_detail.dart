import 'package:flutter/material.dart';
import 'package:ncov_app/model/Country.dart';
import 'package:ncov_app/model/country_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'country_chart.dart';

class CountryDetail extends StatelessWidget {

  final Country countryData;
  CountryDetail({this.countryData});

  final formatData =  NumberFormat.compact(locale: "en");

  @override
  Widget build(BuildContext context) {

    final List<CountryData> data = [
      CountryData(
        detail:  "Cases",
        details: countryData.cases,
        barColor: charts.ColorUtil.fromDartColor(Colors.orangeAccent),
      ),
      CountryData(
        detail: "Deaths",
        details: countryData.deaths,
        barColor: charts.ColorUtil.fromDartColor(Colors.redAccent),
      ),
      CountryData(
        detail: "Active",
        details: countryData.active,
        barColor: charts.ColorUtil.fromDartColor(Colors.blue),
      ),
      CountryData(
        detail: "Recovered",
        details: countryData.recovered,
        barColor: charts.ColorUtil.fromDartColor(Colors.indigo),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text(countryData.country + " detail page"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, countryData),
            _buildCountryStatistic(context, countryData),
             Flexible(child: CountryChart(data: data)),
          ],
        ));
  }

  _buildHeader(BuildContext context, Country countryData) {
    return Container(
        margin: EdgeInsets.all(5),
        height: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.indigo],
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
          color: Colors.indigo.shade800,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(color: Colors.indigo.shade300),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(1, 1),
                spreadRadius: 1,
                blurRadius: 3)
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(countryData.countryInfo.flag,
                      width: 80, fit: BoxFit.fill),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("CASES :   ",
                            style: TextStyle(
                                color: Colors.yellow.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        Text(

                          formatData.format(countryData.cases),

                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("DEATHS : ",
                            style: TextStyle(
                                color: Colors.yellow.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        Text(
                          formatData.format(countryData.deaths),
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                    icon: Icon(
                  Icons.people,
                  color: Colors.deepPurple.shade200,
                ))
              ],
            ),
          ],
        ));
  }

  _buildCountryStatistic(BuildContext context, Country countryData) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 250,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.indigo.shade500, Colors.blue.shade400],
                tileMode: TileMode.repeated, // repeats the gradient over the canvas
              ),
              //color: Colors.indigo.shade600,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(color: Colors.indigo.shade300),
              boxShadow: [
                BoxShadow(
                    color: Colors.indigo,
                    offset: Offset(2, 5),
                    spreadRadius: 1,
                    blurRadius: 3)
              ],
            ),
            child: Container(
              margin: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("TODAY CASES: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(formatData.format(countryData.todayCases), style: TextStyle(color:Colors.yellow.shade700, fontSize: 20, fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("CASES PER MILLION: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(formatData.format(countryData.casesPerOneMillion), style: TextStyle(color:Colors.yellow.shade700, fontSize: 20),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("TEST : ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(formatData.format(countryData.tests), style: TextStyle(color:Colors.yellow.shade700, fontSize: 20),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("TEST PER MILLION: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(formatData.format(countryData.testsPerOneMillion), style: TextStyle(color:Colors.yellow.shade700, fontSize: 20, ),),
                      ),
                    ],
                  ),
                  //SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("TODAY DEATHS :", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(formatData.format(countryData.todayDeaths), style: TextStyle(fontSize: 20, color:Colors.yellow.shade700),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("RECOVERED :", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(formatData.format(countryData.recovered), style: TextStyle(fontSize: 20, color:Colors.yellow.shade700),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("ACTİVE :", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(formatData.format(countryData.active), style: TextStyle(fontSize: 20, color:Colors.yellow.shade700),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text("CRITIC :", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(formatData.format(countryData.critical), style: TextStyle(fontSize: 20, color:Colors.yellow.shade700),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
