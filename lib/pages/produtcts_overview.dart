import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/components/badge.dart';
import 'package:shopping/components/drawer.dart';
import 'package:shopping/models/cart.dart';
import 'package:shopping/models/products_list.dart';
import 'package:shopping/utils/app_routes.dart';

import '../components/product_grid.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewPage extends StatefulWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoritesOnly = false;

  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductsList>(
      context,
      listen: false,
    ).getProdutcs().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Low Quality Things"),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text("Only Favorites"),
                value: FilterOptions.favorites,
              ),
              const PopupMenuItem(
                child: Text("All"),
                value: FilterOptions.all,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
              onPressed: () => Navigator.of(context).pushNamed(AppRoutes.cart),
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 30,
                left: 10,
                right: 10,
              ),
              child: ProductGrid(_showFavoritesOnly),
            ),
    );
  }
}
