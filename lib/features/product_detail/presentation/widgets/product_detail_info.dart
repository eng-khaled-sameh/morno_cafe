import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:caffe_app/features/home/data/models/product_model.dart';
import 'package:caffe_app/features/product_detail/presentation/widgets/product_rating_row.dart';
import 'package:caffe_app/core/widgets/size_selector.dart';
import 'package:flutter/material.dart';

class ProductDetailInfo extends StatefulWidget {
  const ProductDetailInfo({
    super.key,
    required this.product,
    required this.selectedSize,
    required this.onSizeChanged,
  });

  final ProductModel product;
  final String selectedSize;
  final ValueChanged<String> onSizeChanged;

  @override
  State<ProductDetailInfo> createState() => _ProductDetailInfoState();
}

class _ProductDetailInfoState extends State<ProductDetailInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.product.subtitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 14),
          ProductRatingRow(rating: widget.product.rating),
          const SizedBox(height: 16),
          Divider(color: AppColors.greyLight.withValues(alpha: 0.7), height: 1),
          const SizedBox(height: 16),
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.product.description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 18),
          SizeSelector(
            sizeType: widget.product.sizeType,
            selectedSize: widget.selectedSize,
            onSizeSelected: widget.onSizeChanged,
            priceForSize: (size) => 'LE ${widget.product.priceForSize(size).toStringAsFixed(2)}',
          ),
        ],
      ),
    );
  }
}

