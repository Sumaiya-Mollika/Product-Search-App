import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:q_tech_app/search/search.dart';

class ProductDetail extends StatelessWidget {
  //const ProductDetail({Key? key}) : super(key: key);
  final CarouselController? _carouselSlider = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("প্রোডাক্ট ডিটেইল"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
        ),
        body: Container(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'কাঙ্ক্ষিত পণ্যটি খুঁজুন',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        showSearch(context: context, delegate: SearchList());
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.zero,
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 120,
                child: CarouselSlider.builder(
                    itemCount: 1,
                    options: CarouselOptions(
                        viewportFraction: .7,
                        enlargeCenterPage: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayAnimationDuration: Duration(
                          milliseconds: 2000,
                        ),
                        height: MediaQuery.of(context).size.height),
                    carouselController: _carouselSlider,
                    itemBuilder: (context, int index, int pageViewIndex) {
                      // ChangeNotifierProvider.value(
                      //   value: product![index],
                      //   child:
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        // margin: EdgeInsets.symmetric(horizontal: 10),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Column(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                height: 96,
                                alignment: Alignment.center,
                                child: Image.network(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnnnObTCNg1QJoEd9Krwl3kSUnPYTZrxb5Ig&usqp=CAU',
                                  fit: BoxFit.cover,
                                )),
                            Text(
                              'productName',
                              overflow: TextOverflow.ellipsis,
                            ),
                            // Row(
                            //   children: [
                            //     Icon(
                            //       Icons.star,
                            //       size: 12,
                            //       color: Colors.orangeAccent,
                            //     ),
                            //     Icon(
                            //       Icons.star,
                            //       size: 12,
                            //       color: Colors.orangeAccent,
                            //     ),
                            //     Icon(
                            //       Icons.star,
                            //       size: 12,
                            //       color: Colors.orangeAccent,
                            //     ),
                            //     Icon(
                            //       Icons.star,
                            //       size: 12,
                            //       color: Colors.grey,
                            //     ),
                            //     Icon(
                            //       Icons.star,
                            //       size: 12,
                            //       color: Colors.grey,
                            //     ),
                            //     SizedBox(
                            //       width: 5,
                            //     ),
                            //     Text(
                            //       '(4)',
                            //       style:
                            //       TextStyle(color: Colors.black),
                            //     )
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment:
                            //   MainAxisAlignment.start,
                            //   children: [
                            //     Text(
                            //       'TK.${product![index].sellingPrice}  ',
                            //       style:
                            //       TextStyle(color: Colors.green),
                            //     ),
                            //     Text(
                            //       'TK.${product![index].purchasePrice}',
                            //       style: TextStyle(
                            //           color: Colors.grey,
                            //           decoration:
                            //           TextDecoration.lineThrough),
                            //     ),
                            //   ],
                            // ),
                            // FittedBox(
                            //   child: ElevatedButton(
                            //     style: ElevatedButton.styleFrom(
                            //       primary: Colors.amber,
                            //       minimumSize: Size(20, 30),
                            //     ),
                            //     onPressed: () {
                            //       cart.addItem(product![index].id.toString(),double.tryParse(product![index].sellingPrice!)! , product![index].productName,
                            //           'https://bppshops.com/${product![index].productThambnail}');
                            //
                            //       // cart.addItem(product![index].id.toString(), product![index].price, product.title,product.image);
                            //     },
                            //     child: Row(
                            //       mainAxisAlignment:
                            //       MainAxisAlignment.center,
                            //       children: [
                            //         Icon(
                            //           Icons.shopping_bag_outlined,
                            //           color: Colors.white,
                            //           size: 17,
                            //         ),
                            //         Text(
                            //           '  Add to Bag',
                            //           style: TextStyle(
                            //               color: Colors.white),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    }),
              ),
              Text(
                'প্রিঞ্জেলস অনিওন চিপস ৪২ গ্রাম',
                // overflow: TextOverflow.ellipsis,
              ),
              RichText(
                text: TextSpan(
                  text: 'ব্রান্ডঃ প্রিঞ্জেলস',
                  style: DefaultTextStyle.of(context).style,
                  children: const <TextSpan>[
                    TextSpan(
                        text: '.',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' ডিস্ট্রিবিউটরঃ মোঃ মোবারাক হোসেন'),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'ক্রয়মূল্যঃ',
                          // overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '৳ 220',
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'ক্রয়মূল্যঃ',
                          // overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '৳ 220',
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'ক্রয়মূল্যঃ',
                          // overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '৳ 220',
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                'বিস্তারিত',
                // overflow: TextOverflow.ellipsis,
              ),
              Text(
                  'জীবের মধ্যে সবচেয়ে সম্পূর্ণতা মানুষের। কিন্তু সবচেয়ে অসম্পূর্ণ হয়ে সে জন্মগ্রহণ করে। বাঘ ভালুক তার জীবনযাত্রার পনেরো- আনা মূলধন নিয়ে আসে প্রকৃতির মালখানা থেকে। জীবরঙ্গভূমিতে মানুষ এসে দেখা দেয় দুই শূন্য হাতে মুঠো বেঁধে।')
            ],
          ),
        ),
        floatingActionButton: ClipPath(
          clipper: HexagonalClipper(reverse: true),
          child: FloatingActionButton(
              onPressed: () {},
              child: ClipPath(
                clipper: HexagonalClipper(reverse: true),
                child: Container(
                  // height: 220,
                  color: Colors.deepPurple,
                  child: Center(
                    child: Text('এটি কিনুন'),
                  ),
                ),
              )),
        ));
  }
}
