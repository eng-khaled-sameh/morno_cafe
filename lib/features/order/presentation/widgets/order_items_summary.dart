import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:caffe_app/features/cart/logic/cart_cubit.dart';
import 'package:caffe_app/features/cart/logic/cart_state.dart';
import 'package:caffe_app/features/order/presentation/widgets/order_section_card.dart';
import 'package:caffe_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderItemsSummary extends StatelessWidget {
  const OrderItemsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return OrderSectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.orderItems,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 12),
              if (state.items.isEmpty)
                const Text(
                  'No items in cart.',
                  style: TextStyle(color: AppColors.textSecondary),
                )
              else
                ...state.items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _OrderItemRow(
                      title: item.size.isEmpty
                          ? item.title
                          : '${item.title} — ${item.size}',
                      quantity: item.quantity,
                      total: item.price * item.quantity,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  const _OrderItemRow({
    required this.title,
    required this.quantity,
    required this.total,
  });

  final String title;
  final int quantity;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.dark,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'x$quantity',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'LE ${total.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.dark,
          ),
        ),
      ],
    );
  }
}
