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

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
