import 'package:flutter/material.dart';
import '../../models/api_product.dart';
import '../../services/api_product_service.dart';

class ApiProductProvider extends ChangeNotifier {
  final ApiProductService _service = ApiProductService();

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
      _products = await _service.fetchProducts();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
