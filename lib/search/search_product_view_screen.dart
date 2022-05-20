import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:q_tech_app/product/product_details.dart';
import 'package:q_tech_app/provider/search_provider.dart';

class SearchScreen extends StatefulWidget {
  String? image;
  String? productName;
  String? details;
  String? brand;
  String? distributor;
  String? purchase;
  String? selling;
  String? profit;
  SearchScreen(
      {this.productName,
      this.image,
      this.details,
      this.brand,
      this.distributor,
      this.profit,
      this.purchase,
      this.selling});

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
        body: SingleChildScrollView(
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
                              .toUpperCase()
                              .startsWith(searchController.text))
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
              Container(
                height: MediaQuery.of(context).size.height * .9,
                width: MediaQuery.of(context).size.width,
                child: searchItem.searchResultList.isNotEmpty
                    ? GridView.builder(
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
                              Navigator.of(context).pushNamed(
                                ProductDetailsScreen.routeName,
                                arguments: SearchScreen(
                                  productName: searchItem
                                      .searchResultList[index].productName,
                                  image:
                                      searchItem.searchResultList[index].image,
                                  details: searchItem
                                      .searchResultList[index].description,
                                  brand: searchItem
                                      .searchResultList[index].brand!.name,
                                  purchase: searchItem.searchResultList[index]
                                      .charge!.currentCharge
                                      .toString(),
                                  profit: searchItem
                                      .searchResultList[index].charge!.profit
                                      .toString(),
                                  selling: searchItem.searchResultList[index]
                                      .charge!.sellingPrice
                                      .toString(),
                                ),
                              );
                            },
                            child: GridTile(
                              child: Container(
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
                      )
                    : Container(
                        child: const Center(
                          child: Text('No product Found'),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
