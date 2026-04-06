import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:caffe_app/features/home/data/models/product_model.dart';
import 'package:caffe_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SizeSelector extends StatelessWidget {
  final ProductSizeType sizeType;
  final String selectedSize;
  final void Function(String size) onSizeSelected;
  final String Function(String size) priceForSize;
  final bool isCompact;

  const SizeSelector({
    super.key,
    required this.sizeType,
    required this.selectedSize,
    required this.onSizeSelected,
    required this.priceForSize,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (sizeType == ProductSizeType.noSize) {
      return const SizedBox.shrink();
    }

    String getTranslatedSize(BuildContext context, String size) {
      final loc = AppLocalizations.of(context)!;
      if (size == 'Minimum') return loc.minimum;
      if (size == 'Medium') return loc.medium;
      if (size == 'Single') return loc.single;
      if (size == 'Double') return loc.doubleSize;
      return size;
    }

    final sizes = sizeType == ProductSizeType.minMedium
        ? ['Minimum', 'Medium']
        : ['Single', 'Double'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isCompact) ...[
          Text(
            AppLocalizations.of(context)!.size,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
        ],
        Row(
          children: [
            for (var i = 0; i < sizes.length; i++) ...[
              if (i > 0) SizedBox(width: isCompact ? 8 : 12),
              Expanded(
                child: _SizeOption(
                  label: getTranslatedSize(context, sizes[i]),
                  priceLabel: priceForSize(sizes[i]),
                  selected: selectedSize == sizes[i],
                  onTap: () => onSizeSelected(sizes[i]),
                  isCompact: isCompact,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _SizeOption extends StatelessWidget {
  const _SizeOption({
    required this.label,
    required this.priceLabel,
    required this.selected,
    required this.onTap,
    this.isCompact = false,
  });

  final String label;
  final String priceLabel;
  final bool selected;
  final VoidCallback onTap;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? AppColors.primary : AppColors.background;
    final titleColor = selected ? AppColors.surface : AppColors.dark;
    final subColor = selected
        ? AppColors.surface.withValues(alpha: 0.85)
        : AppColors.textSecondary;

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: SizedBox(
          height: isCompact ? 36 : 48,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: isCompact ? 12 : 14,
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                priceLabel,
                style: TextStyle(
                  fontSize: isCompact ? 10 : 11,
                  fontWeight: FontWeight.w500,
                  color: subColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
