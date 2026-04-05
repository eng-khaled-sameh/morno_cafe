import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffe_app/core/widgets/custom_shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/swipe_to_remove.dart';
import '../../data/models/cart_item_model.dart';
import '../../logic/cart_cubit.dart';
import 'quantity_control.dart';
import 'package:caffe_app/core/widgets/size_selector.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SwipeToRemove(
      id: '${item.id}|${item.size}',
      onDismissed: onRemove,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.dark.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: item.imageUrl.startsWith('http')
                  ? CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const CustomShimmer(),
                      errorWidget: (context, url, error) => Container(
                        width: 80,
                        height: 80,
                        color: AppColors.greyLight,
                        child: const Icon(Icons.coffee),
                      ),
                    )
                  : Image.asset(
                      item.imageUrl.isNotEmpty ? item.imageUrl : 'assets/images/Rectangle.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 80,
                        height: 80,
                        color: AppColors.greyLight,
                        child: const Icon(Icons.coffee),
                      ),
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'LE ${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      QuantityControl(
                        quantity: item.quantity,
                        onIncrement: onIncrement,
                        onDecrement: onDecrement,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizeSelector(
                    sizeType: item.sizeType,
                    selectedSize: item.size,
                    isCompact: true,
                    onSizeSelected: (newSize) {
                      context.read<CartCubit>().updateItemSize(
                            item.id,
                            item.size,
                            newSize,
                          );
                    },
                    priceForSize: (size) =>
                        'LE ${item.priceForSize(size).toStringAsFixed(2)}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

