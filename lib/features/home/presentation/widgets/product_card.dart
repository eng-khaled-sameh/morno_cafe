import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:caffe_app/core/widgets/custom_shimmer.dart';
import 'package:caffe_app/features/home/data/models/product_model.dart';
import 'package:caffe_app/features/product_detail/presentation/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';

import 'package:caffe_app/features/home/presentation/widgets/rating_badge.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caffe_app/features/cart/logic/cart_cubit.dart';
import 'package:caffe_app/features/cart/data/models/cart_item_model.dart';
import 'package:caffe_app/features/favorites/logic/favorites_cubit.dart';
import 'package:caffe_app/features/favorites/logic/favorites_state.dart';
import 'package:caffe_app/core/utils/app_formatter.dart';
import '../../../favorites/data/models/favorites_item_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 118,
                      width: double.infinity,
                      child: product.imageUrl.startsWith('http')
                          ? CachedNetworkImage(
                              imageUrl: product.imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CustomShimmer(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : Image.asset(
                              product.imageUrl.isNotEmpty
                                  ? product.imageUrl
                                  : 'assets/images/Rectangle.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: RatingBadge(rating: product.rating),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: BlocBuilder<FavoritesCubit, FavoritesState>(
                        builder: (context, state) {
                          final isFav = context
                              .read<FavoritesCubit>()
                              .isItemFavorited(product.id);
                          return GestureDetector(
                            onTap: () {
                              final favItem = FavoritesItemModel(
                                id: product.id,
                                title: product.name,
                                titleAr: product.nameAr,
                                description: product.description,
                                descriptionAr: product.descriptionAr,
                                price: product.basePrice,
                                imageUrl: product.imageUrl,
                              );
                              context.read<FavoritesCubit>().toggleFavorite(
                                favItem,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.white60,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav
                                    ? AppColors.primaryDark
                                    : AppColors.grey,
                                size: 16,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 6,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'M O R N O',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withOpacity(0.9),
                            letterSpacing: 2.5,
                            shadows: [
                              const Shadow(
                                blurRadius: 3.0,
                                color: Colors.black87,
                                offset: Offset(0, 1.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.getLocalizedName(langCode),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontFamily: 'ReadexPro',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2F2D2C),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.getLocalizedSubtitle(langCode),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontFamily: 'ReadexPro',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9B9B9B),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppFormatter.formatPriceWidget(
                    product.basePrice,
                    langCode,
                    const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2F4B4E),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final defaultSize = switch (product.sizeType) {
                        ProductSizeType.minMedium => 'Minimum',
                        ProductSizeType.singleDouble => 'Single',
                        ProductSizeType.regularCan => 'Regular',
                        ProductSizeType.noSize => '',
                      };

                      final cartItem = CartItemModel(
                        id: product.id,
                        title: product.name,
                        titleAr: product.nameAr,
                        subtitle: product.subtitle,
                        subtitleAr: product.subtitleAr,
                        price: product.priceForSize(defaultSize),
                        imageUrl: product.imageUrl,
                        quantity: 1,
                        size: defaultSize,
                        sizeType: product.sizeType,
                        priceMin: product.priceMin,
                        priceMedium: product.priceMedium,
                        priceSingle: product.priceSingle,
                        priceDouble: product.priceDouble,
                      );
                      context.read<CartCubit>().addItem(cartItem);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            langCode == 'ar' ? 'تم إضافة ${product.nameAr.isNotEmpty ? product.nameAr : product.name} للسلة' : '${product.name} added to cart',
                          ),
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC67C4E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
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
