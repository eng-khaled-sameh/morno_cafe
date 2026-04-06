import 'package:caffe_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caffe_app/features/home/presentation/widgets/home_header.dart';
import 'package:caffe_app/features/home/presentation/widgets/home_search_bar.dart';
import 'package:caffe_app/features/home/presentation/widgets/ads_banner.dart';
import 'package:caffe_app/features/home/presentation/widgets/category_list.dart';
import 'package:caffe_app/features/home/presentation/widgets/products_grid.dart';
import 'package:caffe_app/features/home/presentation/widgets/home_bottom_nav.dart';
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

  Widget _buildHomeShimmer() {
    return Column(
      children: [
        SizedBox(
          height: 38,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CustomShimmer(
                width: 80,
                height: 38,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              mainAxisExtent: 238,
            ),
            itemCount: 4,
            itemBuilder: (context, index) =>
                CustomShimmer(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 260,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF131313), Color(0xFF313131)],
                ),
              ),
            ),
            Column(
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/logo-3.png',
                      height: 80,
                      width: 200,
                    ),
                    const HomeHeader(),
                    const SizedBox(height: 12),
                    const HomeSearchBar(),
                    const SizedBox(height: 12),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is HomeSuccess) {
                          return AdsBanner(ads: state.ads);
                        } else if (state is HomeLoading ||
                            state is HomeInitial) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomShimmer(
                              width: double.infinity,
                              height: 140,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
                Expanded(
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading || state is HomeInitial) {
                        return _buildHomeShimmer();
                      } else if (state is HomeError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(state.message, textAlign: TextAlign.center),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () =>
                                    context.read<HomeCubit>().getCategories(),
                                child: Text(
                                  AppLocalizations.of(context)!.retry,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (state is HomeSuccess) {
                        final categories = state.categories;
                        if (categories.isEmpty) {
                          return Center(
                            child: Text(
                              AppLocalizations.of(context)!.noProductsFound,
                            ),
                          );
                        }

                        if (_selectedIndex >= categories.length) {
                          _selectedIndex = 0;
                        }

                        final selectedCategory = categories[_selectedIndex];

                        return BlocBuilder<SearchCubit, SearchState>(
                          builder: (context, searchState) {
                            if (searchState is! SearchInitial) {
                              return const SearchResultsList();
                            }
                            return Column(
                              children: [
                                CategoryList(
                                  categories: categories,
                                  selectedIndex: _selectedIndex,
                                  onCategorySelected: (index) {
                                    setState(() {
                                      _selectedIndex = index;
                                    });
                                  },
                                ),
                                const SizedBox(height: 18),
                                Expanded(
                                  child: ProductsGrid(
                                    products: selectedCategory.products,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNav(currentIndex: 0),
    );
  }
}
