import 'package:equatable/equatable.dart';

class CartItemEntity extends Equatable {
  final int productId;
  final String title;
  final double price;
  final String imageUrl;
  final int quantity;
  final String selectedSize;
  final int? selectedColor;

  const CartItemEntity({
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
    this.selectedSize = 'M',
    this.selectedColor,
  });

  String get id => '$productId-$selectedSize-${selectedColor ?? 0}';

  double get totalPrice => price * quantity;

  CartItemEntity copyWith({
    int? productId,
    String? title,
    double? price,
    String? imageUrl,
    int? quantity,
    String? selectedSize,
    int? selectedColor,
  }) {
    return CartItemEntity(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
    );
  }

  @override
  List<Object?> get props => [
        productId,
        title,
        price,
        imageUrl,
        quantity,
        selectedSize,
        selectedColor,
      ];
}
