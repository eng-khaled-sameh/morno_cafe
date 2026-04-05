import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SwipeToRemove extends StatelessWidget {
  final Widget child;
  final String id;
  final VoidCallback onDismissed;

  const SwipeToRemove({
    super.key,
    required this.child,
    required this.id,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(id),
      direction: DismissDirection.horizontal,
      onDismissed: (_) => onDismissed(),
      background: _buildBackground(Alignment.centerLeft),
      secondaryBackground: _buildBackground(Alignment.centerRight),
      child: child,
    );
  }

  Widget _buildBackground(Alignment alignment) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.error,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.delete_outline,
        color: Colors.white,
      ),
    );
  }
}
