import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';
@JsonSerializable()
class CategoryDto {
    @JsonKey(name: "id")
    final int? id;
    @JsonKey(name: "name")
    final String? name;


    CategoryDto({
        this.id,
        this.name,

    });

    factory CategoryDto.fromJson(Map<String, dynamic> json) => _$CategoryDtoFromJson(json);

    Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);

    CategoryEntity toDomain() {
      return CategoryEntity(
        id: id,
        name: name,
      );
    }
}
