import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/cart_item_entity.dart';
import '../../domain/use_cases/add_to_cart_use_case.dart';
import '../../domain/use_cases/clear_cart_use_case.dart';
import '../../domain/use_cases/get_cart_use_case.dart';
import '../../domain/use_cases/remove_from_cart_use_case.dart';
import '../../domain/use_cases/update_cart_quantity_use_case.dart';
import 'cart_state.dart';

@lazySingleton
class CartCubit extends Cubit<CartState> {
  final GetCartUseCase _getCartUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final UpdateCartQuantityUseCase _updateCartQuantityUseCase;
  final RemoveFromCartUseCase _removeFromCartUseCase;
  final ClearCartUseCase _clearCartUseCase;

  CartCubit(
    this._getCartUseCase,
    this._addToCartUseCase,
    this._updateCartQuantityUseCase,
    this._removeFromCartUseCase,
    this._clearCartUseCase,
  ) : super(const CartState());

  @override
  void emit(CartState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  Future<void> getCart() async {
    emit(state.copyWith(cartState: const BaseState(isLoading: true)));
    final response = await _getCartUseCase.call();
    if (isClosed) return;

    if (response is SuccessBaseResponse<List<CartItemEntity>>) {
      emit(
        state.copyWith(
          cartState: BaseState(isLoading: false, data: response.data),
        ),
      );
    } else if (response is ErrorBaseResponse<List<CartItemEntity>>) {
      emit(
        state.copyWith(
          cartState: BaseState(
            isLoading: false,
            errorMessage: response.errorMessage,
          ),
        ),
      );
    }
  }

  Future<void> addToCart(CartItemEntity item) async {
    final response = await _addToCartUseCase.call(item);
    if (isClosed) return;

    if (response is SuccessBaseResponse<List<CartItemEntity>>) {
      emit(
        state.copyWith(
          cartState: BaseState(isLoading: false, data: response.data),
          message: '${item.title} added to cart',
        ),
      );
    } else if (response is ErrorBaseResponse<List<CartItemEntity>>) {
      emit(
        state.copyWith(
          cartState: BaseState(
            isLoading: false,
            data: state.items,
            errorMessage: response.errorMessage,
          ),
        ),
      );
    }
  }

  Future<void> incrementQuantity(CartItemEntity item) async {
    await updateQuantity(itemId: item.id, quantity: item.quantity + 1);
  }

  Future<void> decrementQuantity(CartItemEntity item) async {
    if (item.quantity > 1) {
      await updateQuantity(itemId: item.id, quantity: item.quantity - 1);
    } else {
      await removeFromCart(item.id);
    }
  }

  Future<void> updateQuantity({
    required String itemId,
    required int quantity,
  }) async {
    final response = await _updateCartQuantityUseCase.call(
      itemId: itemId,
      quantity: quantity,
    );
    if (isClosed) return;

    if (response is SuccessBaseResponse<List<CartItemEntity>>) {
      emit(
        state.copyWith(
          cartState: BaseState(isLoading: false, data: response.data),
        ),
      );
    } else if (response is ErrorBaseResponse<List<CartItemEntity>>) {
      emit(
        state.copyWith(
          cartState: BaseState(
            isLoading: false,
            data: state.items,
            errorMessage: response.errorMessage,
          ),
        ),
      );
    }
  }

  Future<void> removeFromCart(String itemId) async {
    final response = await _removeFromCartUseCase.call(itemId);
    if (isClosed) return;

    if (response is SuccessBaseResponse<List<CartItemEntity>>) {
      emit(
        state.copyWith(
          cartState: BaseState(isLoading: false, data: response.data),
          message: 'Item removed from cart',
        ),
      );
    } else if (response is ErrorBaseResponse<List<CartItemEntity>>) {
      emit(
        state.copyWith(
          cartState: BaseState(
            isLoading: false,
            data: state.items,
            errorMessage: response.errorMessage,
          ),
        ),
      );
    }
  }

  Future<void> clearCart() async {
    final response = await _clearCartUseCase.call();
    if (isClosed) return;

    if (response is SuccessBaseResponse<void>) {
      emit(
        state.copyWith(
          cartState: const BaseState(isLoading: false, data: []),
          message: 'Cart cleared',
        ),
      );
    } else if (response is ErrorBaseResponse<void>) {
      emit(
        state.copyWith(
          cartState: BaseState(
            isLoading: false,
            data: state.items,
            errorMessage: response.errorMessage,
          ),
        ),
      );
    }
  }
}
