import 'package:flutter/material.dart';

class Local_appbar extends StatefulWidget {
  const Local_appbar({Key? key}) : super(key: key);

  @override
  _Local_appbarState createState() => _Local_appbarState();
}

class _Local_appbarState extends State<Local_appbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Appbar"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              final result =
                  showSearch(context: context, delegate: SearchList());

              print('Result: $result');
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}

class SearchList extends SearchDelegate<String> {
  final search = [
    "kajuNurts",
    "Kosturi",
    "Kishmish",
    "KhejurGur",
    "Kalokeera",
    "AlmondNuts",
    "DryFruits",
    "RowHoney",
  ];

  final recentSearch = [
    "Kaju Nuts",
    "Kosturi",
    "Kishmish",
    "KhejurGur",
  ];

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, '');
            } else {
              query = '';
            }
          },
          icon: Icon(Icons.clear),
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: Icon(Icons.arrow_back),
      );

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              query,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 64,
              ),
            ),
          ],
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentSearch
        : search.where((search) {
            final searchLower = search.toLowerCase();
            final queryLower = query.toLowerCase();

            return searchLower.startsWith(queryLower);
          }).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.substring(0, query.length);
          final remainingText = suggestion.substring(query.length);
          return ListTile(
            onTap: () {
              query = suggestion;
              close(context, suggestion);
              //showResults(context);
            },
            //leading: Icon(Icons.food_bank),
            title: RichText(
              text: TextSpan(
                text: queryText,
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                      text: remainingText,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18,
                      )),
                ],
              ),
            ),
            // title: Text(suggestion),
          );
        },
      );
}
