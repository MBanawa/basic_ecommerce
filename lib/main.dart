import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:basic_ecommerce_app/screens/product_detail_screen.dart';
import 'package:basic_ecommerce_app/screens/products_overview_screen.dart';
import 'package:basic_ecommerce_app/providers/product_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.teal,
          accentColor: Colors.greenAccent,
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreen(),
        routes: {ProductDetailScreen.routeName: (ctx) => ProductDetailScreen()},
      ),
    );
  }
}
