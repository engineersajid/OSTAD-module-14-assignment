import 'package:flutter/material.dart';
import 'package:product_cart_application/core/constants/app_constants.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../viewmodels/product_view_model.dart';
import '../../widgets/cart_badge.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/product_card.dart';
import '../cart/cart_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.appName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
            Text(
              AppConstants.appTagline,
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          CartBadge(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CartView(),
                ),
              );
            },
          ),
          const SizedBox(width: 5),
        ],
      ),

      body: vm.isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : vm.errorMessage != null
          ? _buildErrorState(
        context,
        vm,
      )
          : RefreshIndicator(
        onRefresh: () async {
          await vm.loadProducts();
        },
        child: CustomScrollView(
          physics:
          const AlwaysScrollableScrollPhysics(),
          slivers: [
            // ==========================================
            // SEARCH
            // ==========================================

            SliverToBoxAdapter(
              child: Padding(
                padding:
                const EdgeInsets.fromLTRB(
                  16,
                  8,
                  16,
                  5,
                ),
                child: TextField(
                  onChanged: (value) {
                    context
                        .read<ProductViewModel>()
                        .setSearchQuery(value);
                  },
                  decoration: InputDecoration(
                    hintText:
                    'Search products, categories...',
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                    suffixIcon:
                    vm.searchQuery.isNotEmpty
                        ? IconButton(
                      onPressed: () {
                        context
                            .read<
                            ProductViewModel>()
                            .setSearchQuery(
                          '',
                        );
                      },
                      icon: const Icon(
                        Icons.close,
                      ),
                    )
                        : null,
                  ),
                ),
              ),
            ),

            // ==========================================
            // PROMO BANNER
            // ==========================================

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  height: 165,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF4F46E5),
                        Color(0xFF7C3AED),
                      ],
                    ),
                    borderRadius:
                    BorderRadius.circular(22),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20,
                        bottom: -30,
                        child: Icon(
                          Icons.shopping_bag,
                          size: 180,
                          color: Colors.white
                              .withOpacity(0.08),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            const Text(
                              'SPECIAL OFFER',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                                fontWeight:
                                FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '10% OFF',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 31,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                            Text(
                              'on orders above '
                                  '${AppConstants.currency}'
                                  '${AppConstants.discountThreshold.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ==========================================
            // CATEGORIES
            // ==========================================

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  16,
                  3,
                  16,
                  12,
                ),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: ListView.separated(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount:
                  vm.categories.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 8),
                  itemBuilder:
                      (context, index) {
                    final category =
                    vm.categories[index];

                    return CategoryChip(
                      label: category,
                      selected:
                      vm.selectedCategory ==
                          category,
                      onTap: () {
                        context
                            .read<
                            ProductViewModel>()
                            .setCategory(category);
                      },
                    );
                  },
                ),
              ),
            ),

            // ==========================================
            // FEATURED PRODUCTS
            // ==========================================

            if (vm.searchQuery.isEmpty &&
                vm.selectedCategory == 'All')
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                  const EdgeInsets.fromLTRB(
                    16,
                    24,
                    16,
                    12,
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      const Text(
                        'Featured Products',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${vm.featuredProducts.length} items',
                        style: const TextStyle(
                          color:
                          AppColors.primary,
                          fontSize: 12,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            if (vm.searchQuery.isEmpty &&
                vm.selectedCategory == 'All')
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 275,
                  child: ListView.separated(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    scrollDirection:
                    Axis.horizontal,
                    itemCount:
                    vm.featuredProducts.length,
                    separatorBuilder:
                        (_, __) =>
                    const SizedBox(
                      width: 12,
                    ),
                    itemBuilder:
                        (context, index) {
                      return SizedBox(
                        width: 190,
                        child: ProductCard(
                          product:
                          vm.featuredProducts[
                          index],
                        ),
                      );
                    },
                  ),
                ),
              ),

            // ==========================================
            // ALL PRODUCTS HEADER
            // ==========================================

            SliverToBoxAdapter(
              child: Padding(
                padding:
                const EdgeInsets.fromLTRB(
                  16,
                  25,
                  16,
                  12,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'All Products',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    PopupMenuButton<String>(
                      initialValue:
                      vm.sortOption,
                      onSelected: (value) {
                        context
                            .read<
                            ProductViewModel>()
                            .setSortOption(
                          value,
                        );
                      },
                      itemBuilder: (context) {
                        return const [
                          PopupMenuItem(
                            value: 'Featured',
                            child:
                            Text('Featured'),
                          ),
                          PopupMenuItem(
                            value:
                            'Price: Low to High',
                            child: Text(
                              'Price: Low to High',
                            ),
                          ),
                          PopupMenuItem(
                            value:
                            'Price: High to Low',
                            child: Text(
                              'Price: High to Low',
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Rating',
                            child:
                            Text('Top Rated'),
                          ),
                        ];
                      },
                      child: Container(
                        padding:
                        const EdgeInsets
                            .symmetric(
                          horizontal: 11,
                          vertical: 8,
                        ),
                        decoration:
                        BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius
                              .circular(10),
                          border: Border.all(
                            color:
                            AppColors.border,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.sort,
                              size: 17,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              vm.sortOption ==
                                  'Price: Low to High'
                                  ? 'Low → High'
                                  : vm.sortOption ==
                                  'Price: High to Low'
                                  ? 'High → Low'
                                  : vm.sortOption ==
                                  'Rating'
                                  ? 'Rating'
                                  : 'Featured',
                              style:
                              const TextStyle(
                                fontSize: 11,
                                fontWeight:
                                FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ==========================================
            // PRODUCTS GRID
            // ==========================================

            if (vm.filteredProducts.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons
                              .search_off_rounded,
                          size: 65,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 7),
                        Text(
                          'Try another search or category.',
                          textAlign:
                          TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding:
                const EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  30,
                ),
                sliver: SliverGrid(
                  delegate:
                  SliverChildBuilderDelegate(
                        (context, index) {
                      return ProductCard(
                        product:
                        vm.filteredProducts[
                        index],
                      );
                    },
                    childCount:
                    vm.filteredProducts.length,
                  ),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.62,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(
      BuildContext context,
      ProductViewModel vm,
      ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 65,
              color: AppColors.danger,
            ),
            const SizedBox(height: 15),
            const Text(
              'Unable to load products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              vm.errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: vm.loadProducts,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}