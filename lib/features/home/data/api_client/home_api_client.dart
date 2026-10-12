import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/values/api_endpoints.dart';
import '../models/category_dto.dart';
import '../models/product_dto.dart';

@lazySingleton
class HomeApiClient {
  final Dio _dio;

  HomeApiClient(this._dio);

  Future<List<CategoryDto>> getCategories() async {
    final response = await _dio.get(ApiEndpoints.categories);
    final data = response.data as List<dynamic>;
    return data
        .map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ProductsDto>> getProductsByCategory({
    required int categoryId,
    int? limit,
    int? offset,
  }) async {
    final response = await _dio.get(
      ApiEndpoints.categoryProducts(categoryId),
      queryParameters: {
        'limit': ?limit,
        'offset': ?offset,
      },
    );
    final data = response.data as List<dynamic>;
    return data
        .map((e) => ProductsDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ProductsDto>> getAllProducts({
    int? limit,
    int? offset,
  }) async {
    final response = await _dio.get(
      ApiEndpoints.products,
      queryParameters: {
        'limit': ?limit,
        'offset': ?offset,
      },
    );
    final data = response.data as List<dynamic>;
    return data
        .map((e) => ProductsDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
