import '../entities/api_product.dart';

abstract class ProductRepository {
  Future<List<ApiProduct>> fetchProducts();
  Future<ApiProduct> addProduct(ApiProduct product);
  Future<ApiProduct> updateProduct(ApiProduct product);
  Future<void> deleteProduct(int id);
}
