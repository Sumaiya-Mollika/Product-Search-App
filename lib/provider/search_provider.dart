import 'package:flutter/material.dart';
import 'package:q_tech_app/http_request/http_reqest.dart';
import 'package:q_tech_app/model/model_class.dart';

class SearchProvider with ChangeNotifier {
  SearchSuggestion searchData = SearchSuggestion();
  // List<Results> productResultsList = [];
  // List<Results> productResultsListSearch = [];
  bool loading = false;

  getData(context) async {
    loading = true;
    searchData = await httpRequest(context) as SearchSuggestion;
    //    setState(() {
    //   productSearch = value;
    //   productResultsList = productSearch!.data!.products!.results!;
    //   productResultsListSearch = productResultsList;
    // });
    loading = false;

    notifyListeners();
  }
}
