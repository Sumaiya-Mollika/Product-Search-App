import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:q_tech_app/provider/product_details_provider.dart';
import 'package:q_tech_app/screens/product_details.dart';
import 'package:q_tech_app/provider/search_provider.dart';
import 'package:q_tech_app/screens/search_product_view_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchProvider>(create: (_) => SearchProvider()),
        ChangeNotifierProvider<ProductDetailsProvider>(
            create: (_) => ProductDetailsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: SearchScreen(),
      ),
    );
  }
}
