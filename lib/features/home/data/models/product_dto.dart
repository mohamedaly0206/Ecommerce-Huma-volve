import 'package:ecommerce_app_huma_volve/features/home/data/models/category_dto.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'product_dto.g.dart';

List<ProductsDto> productsDtoFromJson(String str) => List<ProductsDto>.from(json.decode(str).map((x) => ProductsDto.fromJson(x)));

String productsDtoToJson(List<ProductsDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class ProductsDto {
    @JsonKey(name: "id")
    final int? id;
    @JsonKey(name: "title")
    final String? title;
    @JsonKey(name: "price")
    final int? price;
    @JsonKey(name: "description")
    final String? description;
    @JsonKey(name: "category")
    final CategoryDto? category;
    @JsonKey(name: "images")
    final List<String>? images;


    ProductsDto({
        this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.images,
    });

    factory ProductsDto.fromJson(Map<String, dynamic> json) => _$ProductsDtoFromJson(json);

    Map<String, dynamic> toJson() => _$ProductsDtoToJson(this);

    ProductEntity toDomain() {
      return ProductEntity(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category?.toDomain(),
        images: images,
      );
    }
}

