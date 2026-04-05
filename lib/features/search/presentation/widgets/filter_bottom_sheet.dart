import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caffe_app/features/home/logic/home_cubit.dart';
import 'package:caffe_app/features/home/logic/home_state.dart';
import 'package:caffe_app/features/search/logic/search_cubit.dart';
import 'package:caffe_app/features/search/logic/search_state.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    final searchState = context.read<SearchCubit>().state;
    if (searchState is SearchSuccess) {
      selectedCategoryId = searchState.activeCategoryId;
    } else if (searchState is SearchEmpty) {
      selectedCategoryId = searchState.activeCategoryId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter by Category',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              )
            ],
          ),
          const Divider(),
          const SizedBox(height: 16),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                final categories = state.categories;
                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildChip('All', null),
                    for (var cat in categories)
                      _buildChip(cat.name, cat.id),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              context.read<SearchCubit>().search(
                '', // using currentQuery from cubit state by just updating category. Actually cubit clears query? We want to retain query.
                categoryId: selectedCategoryId ?? 'all',
                retainQuery: true,
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC67C4E),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Apply Filter',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChip(String label, String? id) {
    final isSelected = selectedCategoryId == id;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategoryId = id;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFC67C4E) : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
