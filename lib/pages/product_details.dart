import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/product.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name!),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(product.imageUrl!, fit: BoxFit.cover),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            NumberFormat.currency(locale: "pt-BR", symbol: "R\$")
                .format(product.price),
            style: TextStyle(
              color: Colors.green.shade400,
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              product.description!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: "Lato",
              ),
            ),
          )
        ],
      )),
    );
  }
}
