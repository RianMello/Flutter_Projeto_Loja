import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products_list.dart';
import '../models/product.dart';
import 'product_grid_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoritesOnly;
  const ProductGrid(this.showFavoritesOnly);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsList>(context);
    final List<Product> loadedProducts =
        showFavoritesOnly ? provider.favoriteItems : provider.items;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) {
        return ChangeNotifierProvider.value(
          value: loadedProducts[i],
          child: const ProductGridItem(),
        );
      },
    );
  }
}
