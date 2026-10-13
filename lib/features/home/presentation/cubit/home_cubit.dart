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

  HomeCubit(
    this._getCategoriesUseCase,
    this._getProductsByCategoryUseCase,
    this._getAllProductsUseCase,
  ) : super(const HomeState());

  Future<void> init() async {
    await getCategories();
  }

  Future<void> getCategories() async {
    emit(state.copyWith(categoriesState: const BaseState(isLoading: true)));
    final response = await _getCategoriesUseCase.call();

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

  Future<void> getAllProducts() async {
    emit(state.copyWith(productsState: const BaseState(isLoading: true)));
    final response = await _getAllProductsUseCase.call();

    if (response is SuccessBaseResponse<List<ProductEntity>>) {
      emit(
        state.copyWith(
          productsState: BaseState(isLoading: false, data: response.data),
        ),
      );
    } else if (response is ErrorBaseResponse<List<ProductEntity>>) {
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

  Future<void> getProductsByCategory({required int categoryId}) async {
    emit(state.copyWith(productsState: const BaseState(isLoading: true)));
    final response = await _getProductsByCategoryUseCase.call(
      categoryId: categoryId,
    );

    if (response is SuccessBaseResponse<List<ProductEntity>>) {
      emit(
        state.copyWith(
          productsState: BaseState(isLoading: false, data: response.data),
        ),
      );
    } else if (response is ErrorBaseResponse<List<ProductEntity>>) {
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
