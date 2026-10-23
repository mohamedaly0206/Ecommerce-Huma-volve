import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../entities/cart_item_entity.dart';
import '../repo/cart_repo_contract.dart';

@injectable
class UpdateCartQuantityUseCase {
  final CartRepoContract _cartRepoContract;

  UpdateCartQuantityUseCase(this._cartRepoContract);

  Future<BaseResponse<List<CartItemEntity>>> call({
    required String itemId,
    required int quantity,
  }) {
    return _cartRepoContract.updateQuantity(
      itemId: itemId,
      quantity: quantity,
    );
  }
}
