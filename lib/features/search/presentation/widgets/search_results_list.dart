import 'package:caffe_app/features/home/presentation/widgets/product_card.dart';
import 'package:caffe_app/features/search/logic/search_cubit.dart';
import 'package:caffe_app/features/search/logic/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchSuccess) {
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              mainAxisExtent: 238,
            ),
            itemCount: state.results.length,
            itemBuilder: (context, index) {
              return ProductCard(product: state.results[index]);
            },
          );
        } else if (state is SearchEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Icon(Icons.search_off, size: 64, color: Colors.grey),
                 SizedBox(height: 16),
                 Text(
                   'No products found',
                   style: TextStyle(
                     fontSize: 18,
                     color: Colors.grey,
                   ),
                 ),
              ],
            ),
          );
        } else if (state is SearchError) {
          return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
