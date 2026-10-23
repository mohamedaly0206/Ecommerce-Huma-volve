import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../entities/cart_item_entity.dart';
import '../repo/cart_repo_contract.dart';

@injectable
class AddToCartUseCase {
  final CartRepoContract _cartRepoContract;

  AddToCartUseCase(this._cartRepoContract);

  Future<BaseResponse<List<CartItemEntity>>> call(CartItemEntity item) {
    return _cartRepoContract.addToCart(item);
  }
}
