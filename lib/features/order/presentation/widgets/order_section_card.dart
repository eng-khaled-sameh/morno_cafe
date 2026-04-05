import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrderSectionCard extends StatelessWidget {
  const OrderSectionCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.greyLight.withValues(alpha: 0.6)),
      ),
      child: child,
    );
  }
}

