import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping/models/cart_item.dart';
import 'package:shopping/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  bool containedItem(String id) {
    return _items.containsKey(id);
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price! * cartItem.quantity!;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id!,
        (itemToUpdate) => CartItem(
          id: itemToUpdate.id,
          name: itemToUpdate.name,
          productId: itemToUpdate.productId,
          quantity: itemToUpdate.quantity! + 1,
          price: itemToUpdate.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id!,
        () => CartItem(
          id: Random().nextDouble().toString(),
          name: product.name,
          productId: product.id,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (itemToUpdate) => CartItem(
          id: itemToUpdate.id,
          name: itemToUpdate.name,
          productId: itemToUpdate.productId,
          quantity: itemToUpdate.quantity! - 1,
          price: itemToUpdate.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
