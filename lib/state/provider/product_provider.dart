
import 'package:flutter/material.dart';

class Product {
  final String name;
  final double price;
  bool favorite;

  Product({
    required this.name,
    required this.price,
    this.favorite = false,
  });
}

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [
    Product(name: 'Notebook', price: 3500),
    Product(name: 'Mouse', price: 120),
    Product(name: 'Teclado', price: 250),
    Product(name: 'Monitor', price: 900),
  ];

  bool _showOnlyFavorites = false;

  List<Product> get products =>
      _showOnlyFavorites ? _products.where((p) => p.favorite).toList() : _products;

  bool get showOnlyFavorites => _showOnlyFavorites;

  int get favoriteCount => _products.where((p) => p.favorite).length;

  void toggleFilter() {
    _showOnlyFavorites = !_showOnlyFavorites;
    notifyListeners();
  }

  void toggleFavorite(Product product) {
    product.favorite = !product.favorite;
    notifyListeners();
  }
}
