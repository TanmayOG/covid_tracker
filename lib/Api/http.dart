import 'dart:convert';

import 'package:covid_tracker/Model/india_model.dart';
import 'package:covid_tracker/Model/world_state.dart';
import 'package:covid_tracker/Utils/url.dart';

import 'package:http/http.dart' as http;

import '../News/searchBox.dart';

class Apis {
  Future<WorldStateModel> fetchWorldRecords() async {
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> countriesRecords() async {
    // ignore: prefer_typing_uninitialized_variables
    var data;
    final response = await http.get(Uri.parse(AppUrl.countryStatesApi));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<IndiaModel> fetchIndiaReports() async {
    final reponse = await http
        .get(Uri.parse('https://disease.sh/v3/covid-19/countries/India'));
    if (reponse.statusCode == 200) {
      var data = jsonDecode(reponse.body);
      return IndiaModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List> fetchNew() async {
    var key = "Your NewsApi Key!!!";
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&category=health&pageSize=100&apiKey=2c5c87ed1d9f4633bd35459e8c501990';

    // ignore: unused_local_variable
    final response = await http
        .get(Uri.parse(url + '&q=' + SearchBar.searchcontroller.text));

    Map result = jsonDecode(response.body);

    return (result['articles']);
  }
}
