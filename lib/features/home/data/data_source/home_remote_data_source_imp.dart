import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../../../core/errors/failures.dart';
import '../api_client/home_api_client.dart';
import '../models/category_dto.dart';
import '../models/product_dto.dart';
import 'home_remote_data_source_contract.dart';

@Injectable(as: HomeRemoteDataSourceContract)
class HomeRemoteDataSourceImp implements HomeRemoteDataSourceContract {
  final HomeApiClient _homeApiClient;

  HomeRemoteDataSourceImp(this._homeApiClient);

  @override
  Future<BaseResponse<List<CategoryDto>>> getCategories() async {
    try {
      final response = await _homeApiClient.getCategories();
      return SuccessBaseResponse<List<CategoryDto>>(data: response);
    } catch (e) {
      return ErrorBaseResponse<List<CategoryDto>>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }

  @override
  Future<BaseResponse<List<ProductsDto>>> getProductsByCategory({
    required int categoryId,
    int? limit,
    int? offset,
  }) async {
    try {
      final response = await _homeApiClient.getProductsByCategory(
        categoryId: categoryId,
        limit: limit,
        offset: offset,
      );
      return SuccessBaseResponse<List<ProductsDto>>(data: response);
    } catch (e) {
      return ErrorBaseResponse<List<ProductsDto>>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }

  @override
  Future<BaseResponse<List<ProductsDto>>> getAllProducts({
    int? limit,
    int? offset,
  }) async {
    try {
      final response = await _homeApiClient.getAllProducts(
        limit: limit,
        offset: offset,
      );
      return SuccessBaseResponse<List<ProductsDto>>(data: response);
    } catch (e) {
      return ErrorBaseResponse<List<ProductsDto>>(
        errorMessage: ServerFailure.failureHandler(e).errorMessage,
      );
    }
  }
}
