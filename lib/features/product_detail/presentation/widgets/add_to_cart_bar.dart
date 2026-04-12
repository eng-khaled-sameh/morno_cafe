import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:caffe_app/features/cart/data/models/cart_item_model.dart';
import 'package:caffe_app/features/cart/logic/cart_cubit.dart';
import 'package:caffe_app/features/home/data/models/product_model.dart';
import 'package:caffe_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caffe_app/core/utils/app_formatter.dart';

class AddToCartBar extends StatelessWidget {
  const AddToCartBar({
    super.key,
    required this.product,
    required this.selectedSize,
  });

  final ProductModel product;
  final String selectedSize;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(
            top: BorderSide(color: AppColors.greyLight.withValues(alpha: 0.6)),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Localizations.localeOf(context).languageCode == 'ar' ? 'السعر' : 'Price',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AppFormatter.formatPriceWidget(
                    product.priceForSize(selectedSize),
                    Localizations.localeOf(context).languageCode,
                    const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  elevation: 0,
                ),
                onPressed: () {
                  final item = CartItemModel(
                    id: product.id,
                    title: product.name,
                    titleAr: product.nameAr,
                    subtitle: product.subtitle,
                    subtitleAr: product.subtitleAr,
                    price: product.priceForSize(selectedSize),
                    imageUrl: product.imageUrl,
                    quantity: 1,
                    size: selectedSize,
                    sizeType: product.sizeType,
                    priceMin: product.priceMin,
                    priceMedium: product.priceMedium,
                    priceSingle: product.priceSingle,
                    priceDouble: product.priceDouble,
                  );

                  context.read<CartCubit>().addItem(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!.itemAdded),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.addToCart,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
