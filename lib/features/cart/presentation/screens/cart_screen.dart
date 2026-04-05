import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../logic/cart_cubit.dart';
import '../../logic/cart_state.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/order_summary.dart';
import '../../../home/presentation/widgets/home_bottom_nav.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: 'My Cart'),
      bottomNavigationBar: const HomeBottomNav(currentIndex: 2),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return _buildEmptyCart();
          }

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            children: [
              ...state.items.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CartItemCard(
                      item: item,
                      onIncrement: () =>
                          context.read<CartCubit>().incrementQuantity(item.id, item.size),
                      onDecrement: () =>
                          context.read<CartCubit>().decrementQuantity(item.id, item.size),
                      onRemove: () =>
                          context.read<CartCubit>().removeItem(item.id, item.size),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  initialValue: state.notes,
                  maxLines: 3,
                  minLines: 1,
                  maxLength: 200,
                  onChanged: (value) => context.read<CartCubit>().updateNotes(value),
                  decoration: InputDecoration(
                    labelText: 'Order Notes',
                    hintText: 'Any special requests? e.g. less sugar, extra hot...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.greyLight),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: AppColors.primary, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              OrderSummary(
                subtotal: state.subtotal,
                deliveryFee: state.deliveryFee,
                total: state.total,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: AppColors.greyLight,
          ),
          const SizedBox(height: 16),
          const Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
