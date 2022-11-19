import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shopping/data/dummy_data.dart';
import 'product.dart';

class ProductsList with ChangeNotifier {
  final _url =
      'https://shopping-back-end-3b010-default-rtdb.firebaseio.com/products.json';

  final List<Product> _items = [];

  List<Product> get items => [..._items];

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite!).toList();
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> getProdutcs() async {
    _items.clear();
    final response = await http.get(Uri.parse(_url));

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((prodId, prodData) {
      _items.add(
        Product(
          id: prodId,
          description: prodData['description'],
          imageUrl: prodData['imageUrl'],
          price: prodData['price'],
          name: prodData['name'],
        ),
      );
    });
  }

  Future<void> saveProduct(Map<String, Object> datas) {
    bool hasId = datas['id'] != null;
    final product = Product(
      id: hasId ? datas['id'] as String : Random().nextDouble().toString(),
      description: datas['description'] as String,
      imageUrl: datas['imageUrl'] as String,
      price: datas['price'] as double,
      name: datas['name'] as String,
    );

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse(_url),
      body: jsonEncode(
        {
          'name': product.name,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        },
      ),
    );
    final id = jsonDecode(response.body)['name'];
    _items.add(
      Product(
        id: id,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        name: product.name,
        isFavorite: product.isFavorite,
      ),
    );
    notifyListeners();
  }

  Future<void> updateProduct(Product product) {
    int index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
    return Future.value();
  }

  void removeProduct(Product product) {
    int index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _items.removeWhere((prod) => prod.id == product.id);
      notifyListeners();
    }
  }
}
