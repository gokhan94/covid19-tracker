import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ncov_app/data/network.dart';
import 'package:ncov_app/model/Country.dart';
import 'package:ncov_app/widget/country_detail.dart';
import 'package:intl/intl.dart';

class CountryList extends StatefulWidget {
  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  Future<List<Country>> country;

  final formatData = NumberFormat.compact(locale: "en");

  @override
  void initState() {
    super.initState();
    _getCountry();
  }

  Future<List<Country>> _getCountry() async {
    String url =
        "https://disease.sh/v3/covid-19/countries?yesterday=0&twoDaysAgo=0&sort=deaths&allowNull=0";
    Network network = Network(url);

    country = network.countryGetData();
    return country;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text("All Countries"),
        ),
        body: FutureBuilder<List<Country>>(
          future: _getCountry(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Country>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 5,
                      shadowColor: Colors.indigo,
                      color: Colors.grey.shade300,
                      child: ListTile(
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                  snapshot.data[index].countryInfo.flag,
                                  width: 50,
                                  fit: BoxFit.fill)),
                          title: Text(
                            snapshot.data[index].country,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          subtitle: Text(
                            "Deaths: " +
                                formatData.format(snapshot.data[index].deaths),
                            style: TextStyle(
                                color: Colors.redAccent.shade400,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_forward,
                              size: 30,
                            ),
                            color: Colors.grey.shade600,
                            splashColor: Colors.indigoAccent,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CountryDetail(
                                      countryData: snapshot.data[index],
                                    ),
                                  ));
                            },
                          )),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
