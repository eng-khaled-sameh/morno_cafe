import 'package:caffe_app/features/home/presentation/widgets/product_card.dart';
import 'package:caffe_app/features/search/logic/search_state.dart';
import 'package:flutter/material.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({super.key, required this.state});
  final SearchState state;

  @override
  Widget build(BuildContext context) {
    if (state is SearchLoading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (state is SearchSuccess) {
      final successState = state as SearchSuccess;
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            mainAxisExtent: 238,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            return ProductCard(product: successState.results[index]);
          }, childCount: successState.results.length),
        ),
      );
    } else if (state is SearchEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No products found',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    } else if (state is SearchError) {
      return SliverFillRemaining(
        child: Center(
          child: Text(
            (state as SearchError).message,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }
    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }
}
