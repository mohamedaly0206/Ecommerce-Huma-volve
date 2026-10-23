import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../entities/cart_item_entity.dart';
import '../repo/cart_repo_contract.dart';

@injectable
class GetCartUseCase {
  final CartRepoContract _cartRepoContract;

  GetCartUseCase(this._cartRepoContract);

  Future<BaseResponse<List<CartItemEntity>>> call() {
    return _cartRepoContract.getCart();
  }
}
