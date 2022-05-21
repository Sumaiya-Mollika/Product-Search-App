import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:q_tech_app/model/product_detail_model.dart';
import 'package:q_tech_app/model/search_model.dart';

Future<SearchSuggestion?> httpRequest(int pageNumber) async {
  String apiUrl =
      "https://panel.supplyline.network/api/product/search-suggestions/?limit=10&offset=${pageNumber * 10}";
  var response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    return SearchSuggestion.fromJson(
      jsonDecode(
        utf8.decode(response.bodyBytes),
      ),
    );
  } else {
    throw "${response.statusCode}";
  }
}

Future<ProductDetails?> getProductDetail(String slugName) async {
  String apiUrl =
      "https://panel.supplyline.network/api/product-details/${slugName}";
  try {
    var response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return ProductDetails.fromJson(
        jsonDecode(
          utf8.decode(response.bodyBytes),
        ),
      );
    } else {
      throw "${response.statusCode}";
    }
  } catch (e) {
    rethrow;
  }
}
