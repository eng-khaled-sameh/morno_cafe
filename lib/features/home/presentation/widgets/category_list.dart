import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:caffe_app/features/home/data/models/category_model.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  final List<CategoryModel> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          final category = categories[index];
          
          return GestureDetector(
            onTap: () => onCategorySelected(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : const Color(0xFFEDEDED),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                category.name,
                style: GoogleFonts.sora(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? Colors.white : const Color(0xFF2F4B4E),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

