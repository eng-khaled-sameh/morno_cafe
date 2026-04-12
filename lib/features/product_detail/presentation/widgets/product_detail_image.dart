import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:caffe_app/features/favorites/data/models/favorites_item_model.dart';
import 'package:caffe_app/features/favorites/logic/favorites_cubit.dart';
import 'package:caffe_app/features/favorites/logic/favorites_state.dart';
import 'package:caffe_app/features/home/data/models/product_model.dart';
import 'package:caffe_app/core/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailImage extends StatelessWidget {
  const ProductDetailImage({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio:
                MediaQuery.of(context).size.width /
                MediaQuery.of(context).size.height *
                3.5,
            child: product.imageUrl.startsWith('http')
                ? CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) => const CustomShimmer(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Image.asset(
                    product.imageUrl.isNotEmpty
                        ? product.imageUrl
                        : 'assets/images/Rectangle.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: _CircleIconButton(
              icon: Icons.arrow_back,
              onTap: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                final isFav = context.read<FavoritesCubit>().isItemFavorited(
                  product.id,
                );
                return _CircleIconButton(
                  icon: isFav ? Icons.favorite : Icons.favorite_border,
                  iconColor: isFav ? AppColors.primaryDark : AppColors.grey,
                  onTap: () {
                    final item = FavoritesItemModel(
                      id: product.id,
                      title: product.name,
                      titleAr: product.nameAr,
                      description: product.description,
                      descriptionAr: product.descriptionAr,
                      price: product.basePrice,
                      imageUrl: product.imageUrl,
                    );
                    context.read<FavoritesCubit>().toggleFavorite(item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface.withValues(alpha: 0.92),
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, size: 20, color: iconColor ?? AppColors.dark),
        ),
      ),
    );
  }
}
