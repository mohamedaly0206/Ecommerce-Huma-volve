import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/di.dart';
import '../../../../core/dummy_data.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/values/app_strings.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/category_chip.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>()..init(),
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  const _HomeScreenContent();

  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.categoriesState.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.categoriesState.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state.productsState.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.productsState.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final categories = state.categoriesState.data ?? [];
            final products = state.productsState.data ?? [];
            final filteredProducts = _searchQuery.isEmpty
                ? products
                : products.where((p) {
                    final title = p.title?.toLowerCase() ?? '';
                    return title.contains(_searchQuery);
                  }).toList();

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<HomeCubit>().getCategories();
              },
              color: AppTheme.primary,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(alpha: 0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.menu,
                                  color: AppTheme.primary,
                                ),
                              ),
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(
                                  dummyUser.profilePictureUrl,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          Text(
                            AppStrings.explore,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(fontSize: 36),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppStrings.bestTrendyCollection,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 32),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withValues(alpha: 0.05),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: AppStrings.searchClothes,
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                suffixIcon: _searchQuery.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.clear,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () =>
                                            _searchController.clear(),
                                      )
                                    : Container(
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppTheme.primary,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.tune,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          _buildCategoriesSection(context, state, categories),
                        ],
                      ),
                    ),
                  ),
                  _buildProductsSection(context, state, filteredProducts),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(
    BuildContext context,
    HomeState state,
    List<CategoryEntity> categories,
  ) {
    if (state.categoriesState.isLoading) {
      return const SizedBox(
        height: 44,
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppTheme.primary,
            ),
          ),
        ),
      );
    }

    if (state.categoriesState.errorMessage != null && categories.isEmpty) {
      return Row(
        children: [
          Expanded(
            child: Text(
              state.categoriesState.errorMessage ??
                  AppStrings.serverDefaultError,
              style: const TextStyle(color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () => context.read<HomeCubit>().getCategories(),
            child: const Text(AppStrings.retry),
          ),
        ],
      );
    }

    if (categories.isEmpty) {
      return const Text(
        AppStrings.noCategoriesFound,
        style: TextStyle(color: Colors.grey),
      );
    }

    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = state.selectedCategoryIndex == index;
          return CategoryChip(
            label: category.name ?? '',
            isSelected: isSelected,
            onTap: () {
              context.read<HomeCubit>().selectCategory(
                    index: index,
                    categoryId: category.id,
                  );
            },
          );
        },
      ),
    );
  }

  Widget _buildProductsSection(
    BuildContext context,
    HomeState state,
    List<ProductEntity> filteredProducts,
  ) {
    if (state.productsState.isLoading) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 64),
          child: Center(
            child: CircularProgressIndicator(color: AppTheme.primary),
          ),
        ),
      );
    }

    if (state.productsState.errorMessage != null && filteredProducts.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                state.productsState.errorMessage ??
                    AppStrings.serverDefaultError,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final categoryId = state.selectedCategoryId;
                  if (categoryId == null) {
                    context.read<HomeCubit>().getAllProducts();
                  } else {
                    context.read<HomeCubit>().getProductsByCategory(
                          categoryId: categoryId,
                        );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                ),
                child: const Text(
                  AppStrings.retry,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (filteredProducts.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 64),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 48,
                  color: Colors.grey,
                ),
                SizedBox(height: 12),
                Text(
                  AppStrings.noProductsFound,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ProductCard(product: filteredProducts[index]);
          },
          childCount: filteredProducts.length,
        ),
      ),
    );
  }
}
