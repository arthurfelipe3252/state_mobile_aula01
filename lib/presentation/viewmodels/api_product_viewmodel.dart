import 'package:flutter/foundation.dart';
import '../../domain/entities/api_product.dart';
import '../../domain/repositories/product_repository.dart';

class ApiProductViewModel extends ChangeNotifier {
  final ProductRepository repository;

  ApiProductViewModel({required this.repository});

  List<ApiProduct> _products = [];
  bool _isLoading = false;
  String? _error;

  List<ApiProduct> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _products = await repository.fetchProducts();
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addProduct(ApiProduct product) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await repository.addProduct(product);
      final localId = _products.isNotEmpty
          ? _products.map((p) => p.id).reduce((a, b) => a > b ? a : b) + 1
          : 1;
      _products.add(product.copyWith(id: localId));
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProduct(ApiProduct product) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await repository.updateProduct(product);
      final index = _products.indexWhere((p) => p.id == product.id);
      if (index != -1) _products[index] = product;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteProduct(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await repository.deleteProduct(id);
      _products.removeWhere((p) => p.id == id);
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}
