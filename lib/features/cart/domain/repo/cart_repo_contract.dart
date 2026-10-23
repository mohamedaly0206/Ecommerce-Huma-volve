import '../../../../config/base_response/base_response.dart';
import '../entities/cart_item_entity.dart';

abstract class CartRepoContract {
  Future<BaseResponse<List<CartItemEntity>>> getCart();
  Future<BaseResponse<List<CartItemEntity>>> addToCart(CartItemEntity item);
  Future<BaseResponse<List<CartItemEntity>>> updateQuantity({
    required String itemId,
    required int quantity,
  });
  Future<BaseResponse<List<CartItemEntity>>> removeFromCart(String itemId);
  Future<BaseResponse<void>> clearCart();
}
