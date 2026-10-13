import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../entities/category_entity.dart';
import '../repo/home_repo_contract.dart';

@injectable
class GetCategoriesUseCase {
  final HomeRepoContract _homeRepoContract;

  GetCategoriesUseCase(this._homeRepoContract);

  Future<BaseResponse<List<CategoryEntity>>> call() {
    return _homeRepoContract.getCategories();
  }
}
