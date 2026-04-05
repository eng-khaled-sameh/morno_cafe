import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ActionIconButton extends StatelessWidget {
  const ActionIconButton({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
    );
  }
}
