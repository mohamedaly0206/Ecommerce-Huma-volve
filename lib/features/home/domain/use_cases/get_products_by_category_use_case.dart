import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../entities/product_entity.dart';
import '../repo/home_repo_contract.dart';

@injectable
class GetProductsByCategoryUseCase {
  final HomeRepoContract _homeRepoContract;

  GetProductsByCategoryUseCase(this._homeRepoContract);

  Future<BaseResponse<List<ProductEntity>>> call({
    required int categoryId,
    int? limit,
    int? offset,
  }) {
    return _homeRepoContract.getProductsByCategory(
      categoryId: categoryId,
      limit: limit,
      offset: offset,
    );
  }
}
