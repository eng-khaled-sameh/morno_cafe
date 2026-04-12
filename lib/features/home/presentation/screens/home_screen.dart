import 'dart:ui';
import 'package:caffe_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caffe_app/features/home/presentation/widgets/home_header.dart';
import 'package:caffe_app/features/home/presentation/widgets/home_search_bar.dart';
import 'package:caffe_app/features/home/presentation/widgets/ads_banner.dart';
import 'package:caffe_app/features/home/presentation/widgets/category_list.dart';
import 'package:caffe_app/features/home/presentation/widgets/products_grid.dart';
import 'package:caffe_app/features/home/presentation/widgets/home_bottom_nav.dart';
import 'package:caffe_app/features/home/presentation/widgets/app_drawer.dart';
import 'package:caffe_app/features/home/logic/home_cubit.dart';
import 'package:caffe_app/features/home/logic/home_state.dart';
import 'package:caffe_app/features/search/logic/search_cubit.dart';
import 'package:caffe_app/features/search/logic/search_state.dart';
import 'package:caffe_app/features/search/presentation/widgets/search_results_list.dart';
import 'package:caffe_app/core/widgets/custom_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollOffsetNotifier = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _scrollOffsetNotifier.value = _scrollController.offset;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollOffsetNotifier.dispose();
    super.dispose();
  }

  List<Widget> _buildProductsShimmerSlivers() {
    return [
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            mainAxisExtent: 238,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) =>
                CustomShimmer(borderRadius: BorderRadius.circular(16)),
            childCount: 4,
          ),
        ),
      ),
    ];
  }

  Widget _buildProductsGridSliver(HomeSuccess homeState) {
    final categories = homeState.categories;
    if (categories.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Text(AppLocalizations.of(context)!.noProductsFound),
        ),
      );
    }
    if (_selectedIndex >= categories.length) {
      _selectedIndex = 0;
    }
    return ProductsGrid(products: categories[_selectedIndex].products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const AppDrawer(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            ValueListenableBuilder<double>(
              valueListenable: _scrollOffsetNotifier,
              builder: (context, offset, child) {
                return Positioned(
                  top: -offset,
                  left: 0,
                  right: 0,
                  height: 240,
                  child: child!,
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF131313), Color(0xFF313131)],
                  ),
                ),
              ),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, homeState) {
                return BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, searchState) {
                    final isSearching = searchState is! SearchInitial;
                    return CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              const HomeHeader(),
                              const SizedBox(height: 2),
                              const HomeSearchBar(),
                              const SizedBox(height: 12),
                              if (!isSearching) ...[
                                if (homeState is HomeSuccess)
                                  AdsBanner(ads: homeState.ads)
                                else if (homeState is HomeLoading ||
                                    homeState is HomeInitial)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: CustomShimmer(
                                      width: double.infinity,
                                      height: 140,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  )
                                else
                                  const SizedBox(height: 140),
                                const SizedBox(height: 18),
                                Container(
                                  height: 54,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  alignment: Alignment.center,
                                  child:
                                      (homeState is HomeSuccess &&
                                          homeState.categories.isNotEmpty)
                                      ? CategoryList(
                                          categories: homeState.categories,
                                          selectedIndex: _selectedIndex,
                                          onCategorySelected: (index) {
                                            setState(() {
                                              _selectedIndex = index;
                                            });
                                          },
                                        )
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 5,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          itemBuilder: (context, index) =>
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 12,
                                                ),
                                                child: CustomShimmer(
                                                  width: 80,
                                                  height: 38,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                        ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 18)),
                        if (isSearching)
                          SearchResultsList(state: searchState)
                        else if (homeState is HomeLoading ||
                            homeState is HomeInitial)
                          ..._buildProductsShimmerSlivers()
                        else if (homeState is HomeError)
                          SliverFillRemaining(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    homeState.message,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () => context
                                        .read<HomeCubit>()
                                        .getCategories(),
                                    child: Text(
                                      AppLocalizations.of(context)!.retry,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else if (homeState is HomeSuccess)
                          _buildProductsGridSliver(homeState),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNav(currentIndex: 0),
    );
  }
}
