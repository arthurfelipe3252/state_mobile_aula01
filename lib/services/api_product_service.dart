import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_product.dart';

class ApiProductService {
  static const _baseUrl = 'https://fakestoreapi.com/products';

  Future<List<ApiProduct>> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => ApiProduct.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar produtos: ${response.statusCode}');
    }
  }
}
