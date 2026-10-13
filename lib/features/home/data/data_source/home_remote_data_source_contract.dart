import '../../../../config/base_response/base_response.dart';
import '../models/category_dto.dart';
import '../models/product_dto.dart';

abstract class HomeRemoteDataSourceContract {
  Future<BaseResponse<List<CategoryDto>>> getCategories();
  Future<BaseResponse<List<ProductsDto>>> getProductsByCategory({
    required int categoryId,
    int? limit,
    int? offset,
  });
  Future<BaseResponse<List<ProductsDto>>> getAllProducts({
    int? limit,
    int? offset,
  });
}
