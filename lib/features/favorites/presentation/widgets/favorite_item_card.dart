import 'package:caffe_app/core/theme/app_colors.dart';
import '../../data/models/favorites_item_model.dart';
import 'package:caffe_app/features/favorites/presentation/widgets/favorite_item_actions.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffe_app/core/widgets/custom_shimmer.dart';

class FavoriteItemCard extends StatelessWidget {
  const FavoriteItemCard({super.key, required this.item});

  final FavoritesItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LE ${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.dark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 16),
                FavoriteItemActions(item: item),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: item.imageUrl.startsWith('http')
                ? CachedNetworkImage(
                    imageUrl: item.imageUrl,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const CustomShimmer(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Image.asset(
                    item.imageUrl.isNotEmpty
                        ? item.imageUrl
                        : 'assets/images/Rectangle.png',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
          ),
        ],
      ),
    );
  }
}
