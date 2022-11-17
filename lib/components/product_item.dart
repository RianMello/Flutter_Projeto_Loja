import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/products_list.dart';

import 'package:shopping/utils/app_routes.dart';

import 'package:shopping/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl!),
      ),
      title: Text(product.name!),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.productForm,
                  arguments: product,
                );
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Delete Product"),
                    content:
                        Text("Are you sure you want to delete this product?"),
                    actions: [
                      ElevatedButton(
                          onPressed: () => Navigator.of(ctx).pop(true),
                          child: Text("Yes")),
                      TextButton(
                        child: Text("No!"),
                        onPressed: () => Navigator.of(ctx).pop(false),
                      )
                    ],
                  ),
                ).then((value) {
                  if (value ?? false) {
                    Provider.of<ProductsList>(
                      context,
                      listen: false,
                    ).removeProduct(product);
                  }
                });
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
