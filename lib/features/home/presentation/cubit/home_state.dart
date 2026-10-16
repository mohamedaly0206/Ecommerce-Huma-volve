import 'package:equatable/equatable.dart';
import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';

const Object _sentinel = Object();

class HomeState extends Equatable {
  final BaseState<List<CategoryEntity>> categoriesState;
  final BaseState<List<ProductEntity>> productsState;
  final int selectedCategoryIndex;
  final int? selectedCategoryId;
  final bool isLoadingMore;
  final bool hasMoreProducts;

  const HomeState({
    this.categoriesState = const BaseState<List<CategoryEntity>>(),
    this.productsState = const BaseState<List<ProductEntity>>(),
    this.selectedCategoryIndex = 0,
    this.selectedCategoryId,
    this.isLoadingMore = false,
    this.hasMoreProducts = true,
  });

  HomeState copyWith({
    BaseState<List<CategoryEntity>>? categoriesState,
    BaseState<List<ProductEntity>>? productsState,
    int? selectedCategoryIndex,
    Object? selectedCategoryId = _sentinel,
    bool? isLoadingMore,
    bool? hasMoreProducts,
  }) {
    return HomeState(
      categoriesState: categoriesState ?? this.categoriesState,
      productsState: productsState ?? this.productsState,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      selectedCategoryId: identical(selectedCategoryId, _sentinel)
          ? this.selectedCategoryId
          : selectedCategoryId as int?,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMoreProducts: hasMoreProducts ?? this.hasMoreProducts,
    );
  }

  @override
  List<Object?> get props => [
        categoriesState,
        productsState,
        selectedCategoryIndex,
        selectedCategoryId,
        isLoadingMore,
        hasMoreProducts,
      ];
}
