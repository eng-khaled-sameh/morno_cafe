import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:caffe_app/features/cart/logic/cart_cubit.dart';
import 'package:caffe_app/features/cart/logic/cart_state.dart';
import 'package:caffe_app/features/order/presentation/widgets/order_section_card.dart';
import 'package:caffe_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caffe_app/core/utils/app_formatter.dart';

class OrderItemsSummary extends StatelessWidget {
  const OrderItemsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;
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
                Text(
                  langCode == 'ar' ? 'لا توجد عناصر في السلة.' : 'No items in cart.',
                  style: const TextStyle(color: AppColors.textSecondary),
                )
              else
                ...state.items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _OrderItemRow(
                      title: item.size.isEmpty
                          ? (langCode == 'ar' && item.titleAr.isNotEmpty ? item.titleAr : item.title)
                          : '${langCode == 'ar' && item.titleAr.isNotEmpty ? item.titleAr : item.title} — ${_translateSize(context, item.size)}',
                      quantity: item.quantity,
                      total: item.price * item.quantity,
                      langCode: langCode,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  String _translateSize(BuildContext context, String size) {
    if (size.isEmpty) return size;
    final loc = AppLocalizations.of(context)!;
    if (size == 'Minimum') return loc.minimum;
    if (size == 'Medium') return loc.medium;
    if (size == 'Single') return loc.single;
    if (size == 'Double') return loc.doubleSize;
    if (size == 'Regular') return loc.regular;
    if (size == 'Can') return loc.can;
    return size;
  }
}

class _OrderItemRow extends StatelessWidget {
  const _OrderItemRow({
    required this.title,
    required this.quantity,
    required this.total,
    required this.langCode,
  });

  final String title;
  final int quantity;
  final double total;
  final String langCode;

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
          AppFormatter.toArabicNumbers('x$quantity', langCode),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 12),
        AppFormatter.formatPriceWidget(
          total,
          langCode,
          const TextStyle(
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
