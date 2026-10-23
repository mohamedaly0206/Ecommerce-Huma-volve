import 'dart:convert';
import '../../domain/entities/cart_item_entity.dart';

class CartItemDto {
  final int productId;
  final String title;
  final double price;
  final String imageUrl;
  final int quantity;
  final String selectedSize;
  final int? selectedColor;

  CartItemDto({
    required this.productId,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.selectedSize,
    this.selectedColor,
  });

  String get id => '$productId-$selectedSize-${selectedColor ?? 0}';

  factory CartItemDto.fromJson(Map<String, dynamic> json) {
    return CartItemDto(
      productId: json['productId'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 1,
      selectedSize: json['selectedSize'] as String? ?? 'M',
      selectedColor: json['selectedColor'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
    };
  }

  CartItemEntity toDomain() {
    return CartItemEntity(
      productId: productId,
      title: title,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity,
      selectedSize: selectedSize,
      selectedColor: selectedColor,
    );
  }

  factory CartItemDto.fromDomain(CartItemEntity entity) {
    return CartItemDto(
      productId: entity.productId,
      title: entity.title,
      price: entity.price,
      imageUrl: entity.imageUrl,
      quantity: entity.quantity,
      selectedSize: entity.selectedSize,
      selectedColor: entity.selectedColor,
    );
  }
}

List<CartItemDto> cartItemDtoListFromJson(String str) {
  if (str.isEmpty) return [];
  final decoded = json.decode(str);
  if (decoded is List) {
    return decoded
        .map((x) => CartItemDto.fromJson(x as Map<String, dynamic>))
        .toList();
  }
  return [];
}

String cartItemDtoListToJson(List<CartItemDto> data) =>
    json.encode(data.map((x) => x.toJson()).toList());
