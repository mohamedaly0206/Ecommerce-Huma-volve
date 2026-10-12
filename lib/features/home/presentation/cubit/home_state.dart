import 'package:equatable/equatable.dart';
import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';

class HomeState extends Equatable {
  final BaseState<List<CategoryEntity>> categoriesState;
  final BaseState<List<ProductEntity>> productsState;
  final int selectedCategoryIndex;
  final int? selectedCategoryId;

  const HomeState({
    this.categoriesState = const BaseState<List<CategoryEntity>>(),
    this.productsState = const BaseState<List<ProductEntity>>(),
    this.selectedCategoryIndex = 0,
    this.selectedCategoryId,
  });

  HomeState copyWith({
    BaseState<List<CategoryEntity>>? categoriesState,
    BaseState<List<ProductEntity>>? productsState,
    int? selectedCategoryIndex,
    int? selectedCategoryId,
  }) {
    return HomeState(
      categoriesState: categoriesState ?? this.categoriesState,
      productsState: productsState ?? this.productsState,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
    );
  }

  @override
  List<Object?> get props => [
        categoriesState,
        productsState,
        selectedCategoryIndex,
        selectedCategoryId,
      ];
}
