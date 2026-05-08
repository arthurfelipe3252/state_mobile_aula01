import '../../domain/entities/api_product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/api_product_remote_datasource.dart';
import '../models/api_product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ApiProductRemoteDatasource datasource;

  ProductRepositoryImpl({required this.datasource});

  @override
  Future<List<ApiProduct>> fetchProducts() => datasource.fetchProducts();

  @override
  Future<ApiProduct> addProduct(ApiProduct product) =>
      datasource.addProduct(ApiProductModel.fromEntity(product));

  @override
  Future<ApiProduct> updateProduct(ApiProduct product) =>
      datasource.updateProduct(ApiProductModel.fromEntity(product));

  @override
  Future<void> deleteProduct(int id) => datasource.deleteProduct(id);
}
