import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class QuantityBtn extends StatelessWidget {
  const QuantityBtn({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4),
        ],
      ),
      child: Icon(icon, size: 16, color: AppColors.primary),
    );
  }
}
