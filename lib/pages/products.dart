import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopping/components/drawer.dart';
import 'package:shopping/components/product_item.dart';
import 'package:shopping/models/products_list.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsList products = Provider.of(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              ProductItem(product: products.items[i]),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
