import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:q_tech_app/screens/product_details.dart';
import 'package:q_tech_app/provider/search_provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final searchItem = Provider.of<SearchProvider>(context, listen: false);
    searchItem.getData(context);
  }

  @override
  Widget build(BuildContext context) {
    final searchItem = Provider.of<SearchProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFE5E5E5),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 45,
                padding: EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black)),
                child: TextFormField(
                  onChanged: (String value) {
                    setState(() {
                      searchItem.searchResultList = searchItem.resultList
                          .where((element) => element.brand!.slug!
                              .startsWith(searchController.text.toLowerCase()))
                          .toList();
                    });
                  },
                  controller: searchController,
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: "Search Product here",
                      hintStyle: TextStyle(color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent))),
                ),
              ),
              searchItem.searchResultList.isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2 / 3,
                        ),
                        itemCount: searchItem.searchResultList
                            .length, //_searchSuggestion!.data!.products!.results!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(
                                    slagName: searchItem
                                        .searchResultList[index].slug
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            child: GridTile(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 6),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      '${searchItem.searchResultList[index].image}',
                                      fit: BoxFit.cover,
                                    ),
                                    Flexible(
                                      child: Text(
                                        '${searchItem.searchResultList[index].productName}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        'brand: ${searchItem.searchResultList[index].brand!.name}',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: 'ক্রয় ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      '${searchItem.searchResultList[index].charge!.currentCharge}',
                                                  style: const TextStyle(
                                                      color: Colors.pink,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: 'বিক্রয় ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          '${searchItem.searchResultList[index].charge!.sellingPrice}',
                                                      style: const TextStyle(
                                                          color: Colors.pink,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                text: 'লাভ ',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text:
                                                          '${searchItem.searchResultList[index].charge!.profit}',
                                                      style: const TextStyle(
                                                          color: Colors.pink,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              footer: FloatingActionButton(
                                onPressed: () {},
                                child: Icon(Icons.add),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: const Center(
                        child: Text('No product Found'),
                      ),
                    ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                height: 35,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          searchItem.pageDecrement();
                          searchItem.getData(context);
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.arrow_back_ios,
                              size: 15,
                            ),
                            Text("Previous"),
                          ],
                        ),
                      ),
                      Text("Page: " + searchItem.getPageNumber().toString()),
                      GestureDetector(
                        onTap: () {
                          searchItem.pageIncrement();
                          searchItem.getData(context);
                        },
                        child: Row(
                          children: const [
                            Text("Next"),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
