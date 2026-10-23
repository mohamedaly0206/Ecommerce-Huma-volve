import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../repo/cart_repo_contract.dart';

@injectable
class ClearCartUseCase {
  final CartRepoContract _cartRepoContract;

  ClearCartUseCase(this._cartRepoContract);

  Future<BaseResponse<void>> call() {
    return _cartRepoContract.clearCart();
  }
}
