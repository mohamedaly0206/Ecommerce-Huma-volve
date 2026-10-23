import 'package:equatable/equatable.dart';
import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/cart_item_entity.dart';

class CartState extends Equatable {
  final BaseState<List<CartItemEntity>> cartState;
  final String? message;

  const CartState({
    this.cartState = const BaseState<List<CartItemEntity>>(),
    this.message,
  });

  List<CartItemEntity> get items => cartState.data ?? [];
  bool get isEmpty => items.isEmpty;
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  double get subtotal => items.fold(0.0, (sum, item) => sum + item.totalPrice);
  double get tax => subtotal * 0.1;
  double get total => subtotal + tax;

  CartState copyWith({
    BaseState<List<CartItemEntity>>? cartState,
    String? message,
  }) {
    return CartState(
      cartState: cartState ?? this.cartState,
      message: message,
    );
  }

  @override
  List<Object?> get props => [cartState, message];
}
