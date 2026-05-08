import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_product_model.dart';

class ApiProductRemoteDatasource {
  static const _baseUrl = 'https://fakestoreapi.com/products';
  final http.Client client;

  ApiProductRemoteDatasource({required this.client});

  Future<List<ApiProductModel>> fetchProducts() async {
    final response = await client.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((j) => ApiProductModel.fromJson(j)).toList();
    }
    throw Exception('Falha ao carregar produtos: ${response.statusCode}');
  }

  Future<ApiProductModel> addProduct(ApiProductModel product) async {
    final response = await client.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );
    if (response.statusCode == 200) {
      return ApiProductModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Falha ao adicionar produto: ${response.statusCode}');
  }

  Future<ApiProductModel> updateProduct(ApiProductModel product) async {
    final response = await client.put(
      Uri.parse('$_baseUrl/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );
    if (response.statusCode == 200) {
      return ApiProductModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Falha ao atualizar produto: ${response.statusCode}');
  }

  Future<void> deleteProduct(int id) async {
    final response = await client.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Falha ao deletar produto: ${response.statusCode}');
    }
  }
}
