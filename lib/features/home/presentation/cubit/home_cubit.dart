import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/base_response/base_response.dart';
import '../../../../config/base_state/base_state.dart';
import '../../../../core/values/app_strings.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/use_cases/get_all_products_use_case.dart';
import '../../domain/use_cases/get_categories_use_case.dart';
import '../../domain/use_cases/get_products_by_category_use_case.dart';
import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;
  final GetAllProductsUseCase _getAllProductsUseCase;

  static const int _limit = 10;
  int _offset = 0;

  HomeCubit(
    this._getCategoriesUseCase,
    this._getProductsByCategoryUseCase,
    this._getAllProductsUseCase,
  ) : super(const HomeState());

  @override
  void emit(HomeState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  Future<void> init() async {
    await getCategories();
  }

  Future<void> getCategories() async {
    emit(state.copyWith(categoriesState: const BaseState(isLoading: true)));
    final response = await _getCategoriesUseCase.call();
    if (isClosed) return;

    if (response is SuccessBaseResponse<List<CategoryEntity>>) {
      final allCategories = [
        const CategoryEntity(id: null, name: AppStrings.all),
        ...response.data,
      ];

      emit(
        state.copyWith(
          categoriesState: BaseState(isLoading: false, data: allCategories),
        ),
      );

      // Select 'All' by default
      selectCategory(index: 0, categoryId: null);
    } else if (response is ErrorBaseResponse<List<CategoryEntity>>) {
      emit(
        state.copyWith(
          categoriesState: BaseState(
            isLoading: false,
            errorMessage: response.errorMessage,
          ),
        ),
      );
    }
  }

  Future<void> selectCategory({
    required int index,
    required int? categoryId,
  }) async {
    emit(state.copyWith(
      selectedCategoryIndex: index,
      selectedCategoryId: categoryId,
    ));

    if (categoryId == null) {
      await getAllProducts();
    } else {
      await getProductsByCategory(categoryId: categoryId);
    }
  }

  Future<void> getAllProducts({bool isPagination = false}) async {
    if (isPagination) {
      if (state.isLoadingMore ||
          !state.hasMoreProducts ||
          state.productsState.isLoading) {
        return;
      }
      emit(state.copyWith(isLoadingMore: true));
    } else {
      _offset = 0;
      emit(state.copyWith(
        productsState: const BaseState(isLoading: true),
        hasMoreProducts: true,
        isLoadingMore: false,
      ));
    }

    final response = await _getAllProductsUseCase.call(
      limit: _limit,
      offset: _offset,
    );
    if (isClosed) return;

    if (response is SuccessBaseResponse<List<ProductEntity>>) {
      final newProducts = response.data;
      final currentProducts =
          isPagination ? (state.productsState.data ?? []) : <ProductEntity>[];
      final allProducts = [...currentProducts, ...newProducts];
      _offset += newProducts.length;

      emit(
        state.copyWith(
          isLoadingMore: false,
          hasMoreProducts: newProducts.length == _limit,
          productsState: BaseState(
            isLoading: false,
            data: allProducts,
          ),
        ),
      );
    } else if (response is ErrorBaseResponse<List<ProductEntity>>) {
      if (isPagination) {
        emit(
          state.copyWith(
            isLoadingMore: false,
            productsState: BaseState(
              isLoading: false,
              data: state.productsState.data,
              errorMessage: response.errorMessage,
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            productsState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
      }
    }
  }

  Future<void> getProductsByCategory({
    required int categoryId,
    bool isPagination = false,
  }) async {
    if (isPagination) {
      if (state.isLoadingMore ||
          !state.hasMoreProducts ||
          state.productsState.isLoading) {
        return;
      }
      emit(state.copyWith(isLoadingMore: true));
    } else {
      _offset = 0;
      emit(state.copyWith(
        productsState: const BaseState(isLoading: true),
        hasMoreProducts: true,
        isLoadingMore: false,
      ));
    }

    final response = await _getProductsByCategoryUseCase.call(
      categoryId: categoryId,
      limit: _limit,
      offset: _offset,
    );
    if (isClosed) return;

    if (response is SuccessBaseResponse<List<ProductEntity>>) {
      final newProducts = response.data;
      final currentProducts =
          isPagination ? (state.productsState.data ?? []) : <ProductEntity>[];
      final allProducts = [...currentProducts, ...newProducts];
      _offset += newProducts.length;

      emit(
        state.copyWith(
          isLoadingMore: false,
          hasMoreProducts: newProducts.length == _limit,
          productsState: BaseState(
            isLoading: false,
            data: allProducts,
          ),
        ),
      );
    } else if (response is ErrorBaseResponse<List<ProductEntity>>) {
      if (isPagination) {
        emit(
          state.copyWith(
            isLoadingMore: false,
            productsState: BaseState(
              isLoading: false,
              data: state.productsState.data,
              errorMessage: response.errorMessage,
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(
            productsState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
      }
    }
  }

  Future<void> loadMoreProducts() async {
    if (state.isLoadingMore ||
        !state.hasMoreProducts ||
        state.productsState.isLoading) {
      return;
    }

    if (state.selectedCategoryId == null) {
      await getAllProducts(isPagination: true);
    } else {
      await getProductsByCategory(
        categoryId: state.selectedCategoryId!,
        isPagination: true,
      );
    }
  }

  Future<void> refresh() async {
    if (state.categoriesState.data == null ||
        state.categoriesState.data!.isEmpty) {
      await getCategories();
    } else {
      final categoryId = state.selectedCategoryId;
      if (categoryId == null) {
        await getAllProducts();
      } else {
        await getProductsByCategory(categoryId: categoryId);
      }
    }
  }
}
