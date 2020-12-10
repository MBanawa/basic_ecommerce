import 'package:basic_ecommerce_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:basic_ecommerce_app/screens/product_detail_screen.dart';
import 'package:basic_ecommerce_app/screens/products_overview_screen.dart';
import 'package:basic_ecommerce_app/providers/product_provider.dart';
import 'package:basic_ecommerce_app/providers/auth.dart';
import 'package:basic_ecommerce_app/providers/cart.dart';
import 'package:basic_ecommerce_app/providers/order.dart';
import 'package:basic_ecommerce_app/screens/auth_screen.dart';
import 'package:basic_ecommerce_app/screens/cart_screen.dart';
import 'package:basic_ecommerce_app/screens/edit_product_screen.dart';
import 'package:basic_ecommerce_app/screens/order_screen.dart';
import 'package:basic_ecommerce_app/screens/user_products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
            create: null,
            update: (ctx, auth, previousProducts) => Products(
                  auth.token,
                  auth.userId,
                  previousProducts == null ? [] : previousProducts.items,
                )),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
            create: null,
            update: (ctx, auth, previousOrders) => Orders(
                  auth.token,
                  auth.userId,
                  previousOrders == null ? [] : previousOrders.orders,
                )),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.teal,
            accentColor: Colors.greenAccent,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrderScreen.routeName: (ctx) => OrderScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
