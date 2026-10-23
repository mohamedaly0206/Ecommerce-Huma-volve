import 'package:injectable/injectable.dart';
import '../../../../config/security_storage/security_storage.dart';
import '../models/cart_item_dto.dart';
import 'cart_local_data_source_contract.dart';

@Injectable(as: CartLocalDataSourceContract)
class CartLocalDataSourceImp implements CartLocalDataSourceContract {
  final SecurityStorage _securityStorage;
  static const String _cartKey = 'user_cart_items';

  CartLocalDataSourceImp(this._securityStorage);

  @override
  Future<List<CartItemDto>> getCartItems() async {
    final rawJson = await _securityStorage.getSecuredString(_cartKey);
    if (rawJson.isEmpty) {
      return [];
    }
    try {
      return cartItemDtoListFromJson(rawJson);
    } catch (_) {
      return [];
    }
  }

  @override
  Future<List<CartItemDto>> saveCartItems(List<CartItemDto> items) async {
    final encoded = cartItemDtoListToJson(items);
    await _securityStorage.setSecuredString(_cartKey, encoded);
    return items;
  }

  @override
  Future<void> clearCart() async {
    await _securityStorage.deleteSecuredString(_cartKey);
  }
}
