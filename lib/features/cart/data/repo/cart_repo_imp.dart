import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/repo/cart_repo_contract.dart';
import '../data_source/cart_local_data_source_contract.dart';
import '../models/cart_item_dto.dart';

@Injectable(as: CartRepoContract)
class CartRepoImp implements CartRepoContract {
  final CartLocalDataSourceContract _cartLocalDataSource;

  CartRepoImp(this._cartLocalDataSource);

  @override
  Future<BaseResponse<List<CartItemEntity>>> getCart() async {
    try {
      final dtos = await _cartLocalDataSource.getCartItems();
      return SuccessBaseResponse(
        data: dtos.map((e) => e.toDomain()).toList(),
      );
    } catch (e) {
      return ErrorBaseResponse(errorMessage: e.toString());
    }
  }

  @override
  Future<BaseResponse<List<CartItemEntity>>> addToCart(
    CartItemEntity item,
  ) async {
    try {
      final dtos = await _cartLocalDataSource.getCartItems();
      final itemDto = CartItemDto.fromDomain(item);
      final existingIndex = dtos.indexWhere((e) => e.id == itemDto.id);

      if (existingIndex != -1) {
        final existing = dtos[existingIndex];
        dtos[existingIndex] = CartItemDto(
          productId: existing.productId,
          title: existing.title,
          price: existing.price,
          imageUrl: existing.imageUrl,
          quantity: existing.quantity + itemDto.quantity,
          selectedSize: existing.selectedSize,
          selectedColor: existing.selectedColor,
        );
      } else {
        dtos.add(itemDto);
      }

      final saved = await _cartLocalDataSource.saveCartItems(dtos);
      return SuccessBaseResponse(
        data: saved.map((e) => e.toDomain()).toList(),
      );
    } catch (e) {
      return ErrorBaseResponse(errorMessage: e.toString());
    }
  }

  @override
  Future<BaseResponse<List<CartItemEntity>>> updateQuantity({
    required String itemId,
    required int quantity,
  }) async {
    try {
      final dtos = await _cartLocalDataSource.getCartItems();
      final index = dtos.indexWhere((e) => e.id == itemId);

      if (index != -1) {
        if (quantity <= 0) {
          dtos.removeAt(index);
        } else {
          final current = dtos[index];
          dtos[index] = CartItemDto(
            productId: current.productId,
            title: current.title,
            price: current.price,
            imageUrl: current.imageUrl,
            quantity: quantity,
            selectedSize: current.selectedSize,
            selectedColor: current.selectedColor,
          );
        }
      }

      final saved = await _cartLocalDataSource.saveCartItems(dtos);
      return SuccessBaseResponse(
        data: saved.map((e) => e.toDomain()).toList(),
      );
    } catch (e) {
      return ErrorBaseResponse(errorMessage: e.toString());
    }
  }

  @override
  Future<BaseResponse<List<CartItemEntity>>> removeFromCart(
    String itemId,
  ) async {
    try {
      final dtos = await _cartLocalDataSource.getCartItems();
      dtos.removeWhere((e) => e.id == itemId);
      final saved = await _cartLocalDataSource.saveCartItems(dtos);
      return SuccessBaseResponse(
        data: saved.map((e) => e.toDomain()).toList(),
      );
    } catch (e) {
      return ErrorBaseResponse(errorMessage: e.toString());
    }
  }

  @override
  Future<BaseResponse<void>> clearCart() async {
    try {
      await _cartLocalDataSource.clearCart();
      return SuccessBaseResponse(data: null);
    } catch (e) {
      return ErrorBaseResponse(errorMessage: e.toString());
    }
  }
}
