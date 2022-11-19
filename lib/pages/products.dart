import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopping/components/drawer.dart';
import 'package:shopping/components/product_item.dart';
import 'package:shopping/models/products_list.dart';
import 'package:shopping/utils/app_routes.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  Future<void>? _refreshProducts(BuildContext context) {
    Provider.of<ProductsList>(
      context,
      listen: false,
    ).getProdutcs();
  }

  @override
  Widget build(BuildContext context) {
    final ProductsList products = Provider.of(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.productForm);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context)!,
        child: Padding(
          padding: const EdgeInsets.all(8),
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
      ),
    );
  }
}
