import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:q_tech_app/model/model_class.dart';

//class ProductServices{
// with ChangeNotifier{
//   List<Results> productResultsList = [];
// List<Results> productResultsListSearch = [];

String apiUrl =
    "https://panel.supplyline.network/api/product/search-suggestions/?limit=10&offset=10";

Future<SearchSuggestion?> httpRequest(context) async {
  var response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    return SearchSuggestion.fromJson(jsonDecode(response.body));
  } else {
    throw "${response.statusCode}";
  }
}
  
//}
