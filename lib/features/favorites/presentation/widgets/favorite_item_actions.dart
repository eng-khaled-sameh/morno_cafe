import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/favorites_item_model.dart';
import '../../logic/favorites_cubit.dart';
import '../../../cart/logic/cart_cubit.dart';
import '../../../cart/data/models/cart_item_model.dart';
import 'package:caffe_app/features/home/data/models/product_model.dart';
import 'package:caffe_app/features/favorites/presentation/widgets/action_icon_button.dart';
import 'package:caffe_app/features/favorites/presentation/widgets/order_now_button.dart';
import 'package:flutter/material.dart';

class FavoriteItemActions extends StatelessWidget {
  const FavoriteItemActions({super.key, required this.item});

  final FavoritesItemModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ActionIconButton(
          icon: Icons.heart_broken,
          onTap: () {
            context.read<FavoritesCubit>().removeItem(item.id);
          },
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OrderNowButton(
            text: 'Add to Cart',
            onPressed: () {
              final cartItem = CartItemModel(
                id: item.id,
                title: item.title,
                subtitle: 'From Favorites',
                price: item.price,
                imageUrl: item.imageUrl,
                quantity: 1,
                size: '',
                sizeType: ProductSizeType.noSize,
                priceMin: item.price,
                priceMedium: item.price,
                priceSingle: item.price,
                priceDouble: item.price,
              );
              context.read<CartCubit>().addItem(cartItem);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${item.title} added to cart'),
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
