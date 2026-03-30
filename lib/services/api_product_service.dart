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

  Future<ApiProduct> addProduct(ApiProduct product) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 200) {
      return ApiProduct.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao adicionar produto: ${response.statusCode}');
    }
  }

  Future<ApiProduct> updateProduct(ApiProduct product) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 200) {
      return ApiProduct.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao atualizar produto: ${response.statusCode}');
    }
  }

  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar produto: ${response.statusCode}');
    }
  }
}
