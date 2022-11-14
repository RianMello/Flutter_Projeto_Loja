import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping/models/cart.dart';
import 'package:shopping/models/cart_item.dart';

class CartItemDetails extends StatelessWidget {
  final CartItem cartItem;
  const CartItemDetails(this.cartItem, {super.key});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: "pt-BR", symbol: "");
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 36,
        ),
      ),
      confirmDismiss: (_) {
        return showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Delete item"),
            content: Text(
                "Are you sure you want to delete this item from your cart?"),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("Yes")),
              TextButton(
                child: Text("No!"),
                onPressed: () => Navigator.of(context).pop(false),
              )
            ],
          ),
        );
      },
      onDismissed: (_) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(cartItem.productId!);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(currency.format(cartItem.price),
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
            title: Text(
              '${cartItem.name}',
              style: const TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              "Total:${currency.format(cartItem.price! * cartItem.quantity!)}",
            ),
            trailing: Text(
              "${cartItem.quantity}x",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
