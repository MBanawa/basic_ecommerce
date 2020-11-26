import 'package:basic_ecommerce_app/providers/order.dart';
import 'package:basic_ecommerce_app/widgets/app_drawer.dart';
import 'package:basic_ecommerce_app/widgets/order_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout Details'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx, i) => OrderTile(orderData.orders[i]),
      ),
    );
  }
}
