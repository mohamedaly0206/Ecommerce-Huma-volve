import '../../../../config/base_response/base_response.dart';
import '../entities/category_entity.dart';
import '../entities/product_entity.dart';

abstract class HomeRepoContract {
  Future<BaseResponse<List<CategoryEntity>>> getCategories();
  Future<BaseResponse<List<ProductEntity>>> getProductsByCategory({
    required int categoryId,
    int? limit,
    int? offset,
  });
  Future<BaseResponse<List<ProductEntity>>> getAllProducts({
    int? limit,
    int? offset,
  });
}
