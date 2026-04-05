import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EditableInfoRow extends StatelessWidget {
  const EditableInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.controller,
    this.hintText,
    this.keyboardType,
    this.maxLines = 1,
    this.isRequired = false,
    this.errorText,
    this.onChanged,
  });

  final IconData icon;
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final bool isRequired;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Icon(icon, color: AppColors.dark, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  if (isRequired)
                    const Text(
                      ' *',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              TextField(
                controller: controller,
                keyboardType: keyboardType,
                maxLines: maxLines,
                onChanged: onChanged,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.dark,
                  height: 1.35,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: AppColors.greyLight,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  errorText: errorText,
                  errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.greyLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

