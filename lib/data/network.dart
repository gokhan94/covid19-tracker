import 'dart:convert';
import 'package:http/http.dart';
import 'package:ncov_app/model/CoronaNews.dart';
import 'package:ncov_app/model/Country.dart';

class Network {
  final String url;

  Network(this.url);

  Future globalFetchData() async {
    Response response = await get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future<List<Country>> countryGetData() async {
    final Response response = await get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((country) => Country.fromJson(country)).toList();
    } else {
      return null;
    }
  }

  Future<CoronaNews> newsFetchData() async {
    final Response response = await get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      return CoronaNews.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}
