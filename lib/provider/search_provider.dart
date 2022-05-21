import 'package:flutter/material.dart';
import 'package:q_tech_app/http_request/http_reqest.dart';
import 'package:q_tech_app/model/search_model.dart';

class SearchProvider with ChangeNotifier {
  SearchSuggestion searchData = SearchSuggestion();
  List<Results> resultList = [];
  List<Results> searchResultList = [];
  bool loading = false;
  int pageNumber = 0;
  int getPageNumber() => pageNumber + 1;

  pageIncrement() {
    if (pageNumber < 11) {
      pageNumber++;
      notifyListeners();
    }
  }

  pageDecrement() {
    if (pageNumber > 0) {
      pageNumber--;
      notifyListeners();
    }
  }

  getData(context) async {
    loading = true;
    searchData = await httpRequest(pageNumber) as SearchSuggestion;
    resultList = searchData.data!.products!.results!;
    searchResultList = resultList;
    loading = false;

    notifyListeners();
  }
}
