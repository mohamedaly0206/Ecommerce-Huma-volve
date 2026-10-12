import 'package:equatable/equatable.dart';
import 'category_entity.dart';

class ProductEntity extends Equatable {
  final int? id;
  final String? title;
  final int? price;
  final String? description;
  final CategoryEntity? category;
  final List<String>? images;

  const ProductEntity({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.images,
  });

  String get firstImage {
    if (images != null && images!.isNotEmpty) {
      final img = images!.first.replaceAll(RegExp(r'[\[\]"]'), '').trim();
      return img;
    }
    return '';
  }

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        category,
        images,
      ];
}
