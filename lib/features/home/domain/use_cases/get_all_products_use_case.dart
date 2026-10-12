import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../entities/product_entity.dart';
import '../repo/home_repo_contract.dart';

@injectable
class GetAllProductsUseCase {
  final HomeRepoContract _homeRepoContract;

  GetAllProductsUseCase(this._homeRepoContract);

  Future<BaseResponse<List<ProductEntity>>> call({
    int? limit,
    int? offset,
  }) {
    return _homeRepoContract.getAllProducts(
      limit: limit,
      offset: offset,
    );
  }
}
