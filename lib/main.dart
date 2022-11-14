import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/pages/orders_page.dart';

import 'utils/app_routes.dart';

import 'pages/produtcts_overview.dart';
import 'pages/product_details.dart';
import 'pages/cart_page.dart';

import 'models/products_list.dart';
import 'models/cart.dart';
import 'models/order_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        )
      ],
      child: MaterialApp(
        title: 'Utility store',
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
            primary: Colors.purple.shade600,
            secondary: Colors.deepOrange,
          ),
          canvasColor: Colors.purple.shade50,
          textTheme: theme.textTheme.copyWith(
            headline1: const TextStyle(
              fontFamily: "Lato",
              fontSize: 16,
            ),
            headline2: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            bodyText1: const TextStyle(
              fontFamily: "Lato",
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
        routes: {
          AppRoutes.home: (context) => const ProductsOverviewPage(),
          AppRoutes.productDetails: (context) => const ProductDetailsPage(),
          AppRoutes.cart: (context) => CartPage(),
          AppRoutes.orders: (context) => const OrdersPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
