import 'package:flutter/foundation.dart';
import '../../domain/entities/product.dart';

class ProductViewModel extends ChangeNotifier {
  final List<Product> _products = [
    const Product(name: 'Notebook', price: 3500),
    const Product(name: 'Mouse', price: 120),
    const Product(name: 'Teclado', price: 250),
    const Product(name: 'Monitor', price: 900),
  ];

  bool _showOnlyFavorites = false;

  List<Product> get products => _showOnlyFavorites
      ? _products.where((p) => p.favorite).toList()
      : List.unmodifiable(_products);

  bool get showOnlyFavorites => _showOnlyFavorites;

  int get favoriteCount => _products.where((p) => p.favorite).length;

  void toggleFilter() {
    _showOnlyFavorites = !_showOnlyFavorites;
    notifyListeners();
  }

  void toggleFavorite(Product product) {
    final index = _products.indexOf(product);
    if (index != -1) {
      _products[index] = product.copyWith(favorite: !product.favorite);
      notifyListeners();
    }
  }
}
