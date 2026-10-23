import '../models/cart_item_dto.dart';

abstract class CartLocalDataSourceContract {
  Future<List<CartItemDto>> getCartItems();
  Future<List<CartItemDto>> saveCartItems(List<CartItemDto> items);
  Future<void> clearCart();
}
