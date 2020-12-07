import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:basic_ecommerce_app/providers/cart.dart';
import 'package:flutter/foundation.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    this.id,
    this.amount,
    this.products,
    this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'https://basic-ecommerce-5d066.firebaseio.com/orders.json';
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cartProduct) => {
                    'id': cartProduct.id,
                    'title': cartProduct.title,
                    'quantity': cartProduct.quantity,
                    'price': cartProduct.price,
                  })
              .toList(),
        }));
    _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          dateTime: timestamp,
          products: cartProducts,
        ));
    notifyListeners();
  }
}
