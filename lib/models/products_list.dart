import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shopping/data/dummy_data.dart';
import 'product.dart';

class ProductsList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite!).toList();
  }

  int get itemsCount {
    return _items.length;
  }

  void saveProduct(Map<String, Object> datas) {
    bool hasId = datas['id'] != null;
    final product = Product(
      id: hasId ? datas['id'] as String : Random().nextDouble().toString(),
      description: datas['description'] as String,
      imageUrl: datas['imageUrl'] as String,
      price: datas['price'] as double,
      name: datas['name'] as String,
    );

    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product) {
    int index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _items.removeWhere((prod) => prod.id == product.id);
      notifyListeners();
    }
  }
}
