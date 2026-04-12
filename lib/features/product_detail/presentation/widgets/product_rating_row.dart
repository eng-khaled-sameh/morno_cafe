import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:caffe_app/core/utils/app_formatter.dart';
import 'package:flutter/material.dart';

class ProductRatingRow extends StatelessWidget {
  const ProductRatingRow({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;
    return Row(
      children: [
        const Icon(Icons.star, size: 18, color: AppColors.warning),
        const SizedBox(width: 6),
        Text(
          AppFormatter.toArabicNumbers(rating.toStringAsFixed(1), langCode),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
