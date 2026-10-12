import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repo/home_repo_contract.dart';
import '../data_source/home_remote_data_source_contract.dart';
import '../models/category_dto.dart';
import '../models/product_dto.dart';

@Injectable(as: HomeRepoContract)
class HomeRepoImp implements HomeRepoContract {
  final HomeRemoteDataSourceContract _homeRemoteDataSource;

  HomeRepoImp(this._homeRemoteDataSource);

  @override
  Future<BaseResponse<List<CategoryEntity>>> getCategories() async {
    final response = await _homeRemoteDataSource.getCategories();

    switch (response) {
      case SuccessBaseResponse<List<CategoryDto>> successResponse:
        return SuccessBaseResponse<List<CategoryEntity>>(
          data: successResponse.data.map((dto) => dto.toDomain()).toList(),
        );
      case ErrorBaseResponse<List<CategoryDto>> errorResponse:
        return ErrorBaseResponse<List<CategoryEntity>>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<List<ProductEntity>>> getProductsByCategory({
    required int categoryId,
    int? limit,
    int? offset,
  }) async {
    final response = await _homeRemoteDataSource.getProductsByCategory(
      categoryId: categoryId,
      limit: limit,
      offset: offset,
    );

    switch (response) {
      case SuccessBaseResponse<List<ProductsDto>> successResponse:
        return SuccessBaseResponse<List<ProductEntity>>(
          data: successResponse.data.map((dto) => dto.toDomain()).toList(),
        );
      case ErrorBaseResponse<List<ProductsDto>> errorResponse:
        return ErrorBaseResponse<List<ProductEntity>>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }

  @override
  Future<BaseResponse<List<ProductEntity>>> getAllProducts({
    int? limit,
    int? offset,
  }) async {
    final response = await _homeRemoteDataSource.getAllProducts(
      limit: limit,
      offset: offset,
    );

    switch (response) {
      case SuccessBaseResponse<List<ProductsDto>> successResponse:
        return SuccessBaseResponse<List<ProductEntity>>(
          data: successResponse.data.map((dto) => dto.toDomain()).toList(),
        );
      case ErrorBaseResponse<List<ProductsDto>> errorResponse:
        return ErrorBaseResponse<List<ProductEntity>>(
          errorMessage: errorResponse.errorMessage,
        );
    }
  }
}
