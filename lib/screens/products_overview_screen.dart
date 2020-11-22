import 'package:flutter/material.dart';

import 'package:basic_ecommerce_app/widgets/products_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: ProductsGrid(),
    );
    return scaffold;
  }
}
