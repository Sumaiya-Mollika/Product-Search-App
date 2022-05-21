import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:q_tech_app/provider/product_details_provider.dart';
import 'package:q_tech_app/screens/search_product_view_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  //const ProductDetailsScreen({Key? key}) : super(key: key);

  final String slagName;
  ProductDetailsScreen({required this.slagName});
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  CarouselController _carouselSlider = CarouselController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetailData();
  }

  getDetailData() {
    final productDetail =
        Provider.of<ProductDetailsProvider>(context, listen: false);
    productDetail.getProductDetails(widget.slagName);
    productDetail.resetCartButton();
  }

  @override
  Widget build(BuildContext context) {
    final productDetail = Provider.of<ProductDetailsProvider>(context);
    //final args = ModalRoute.of(context)!.settings.arguments as SearchScreen;
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFE5E5E5),
        title: Text('প্রোডাক্ট ডিটেইল'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: productDetail.isLoading == false
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'কাঙ্ক্ষিত পণ্যটি খুঁজুন',
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search), onPressed: () {}),
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
                    height: 16,
                  ),
                  SizedBox(
                    height: 250,
                    width: 150,
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
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              // border: Border.all(
                              //     color: Colors.grey, width: 1)
                            ),
                            child: Container(
                                height: 120,
                                width: 90,
                                // alignment: Alignment.center,
                                child: Image.network(
                                  "${productDetail.productDetails!.data!.image}",
                                  // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnnnObTCNg1QJoEd9Krwl3kSUnPYTZrxb5Ig&usqp=CAU',
                                  fit: BoxFit.cover,
                                )),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${productDetail.productDetails!.data!.productName}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20),
                  ),
                  RichText(
                    text: TextSpan(
                      text:
                          'ব্রান্ডঃ ${productDetail.productDetails!.data!.brand!.name}',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: '.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink,
                                fontSize: 30)),
                        TextSpan(
                          text: ' ডিস্ট্রিবিউটরঃ মোঃ মোবারাক হোসেন',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ক্রয়মূল্যঃ',
                              style:
                                  TextStyle(color: Colors.pink, fontSize: 20),
                              // overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                                '৳ ${productDetail.productDetails!.data!.charge!.currentCharge}',
                                style:
                                    TextStyle(color: Colors.pink, fontSize: 20)
                                // overflow: TextOverflow.ellipsis,
                                ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('বিক্রয়মূল্যঃ', style: TextStyle(fontSize: 20)
                                // overflow: TextOverflow.ellipsis,
                                ),
                            Text(
                                '৳ ${productDetail.productDetails!.data!.charge!.sellingPrice}',
                                style: TextStyle(fontSize: 20)
                                // overflow: TextOverflow.ellipsis,
                                ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('লাভঃ', style: TextStyle(fontSize: 20)
                                // overflow: TextOverflow.ellipsis,
                                ),
                            Text(
                                '৳ ${productDetail.productDetails!.data!.charge!.profit}',
                                style: TextStyle(fontSize: 20)
                                // overflow: TextOverflow.ellipsis,
                                ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'বিস্তারিত',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    // overflow: TextOverflow.ellipsis,
                  ),
                  Html(
                    data: '${productDetail.productDetails!.data!.description}',
                  )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 150),
        child: ClipPath(
          clipper: HexagonalClipper(reverse: true),
          child: FloatingActionButton.large(
              onPressed: () {},
              child: ClipPath(
                clipper: HexagonalClipper(reverse: true),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.deepPurple,
                  ),
// height: 220,

                  child: Center(
                    child: Text('এটি কিনুন'),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
