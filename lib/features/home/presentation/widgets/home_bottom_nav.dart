import 'package:flutter/material.dart';
import 'package:caffe_app/features/home/presentation/screens/home_screen.dart';
import 'package:caffe_app/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:caffe_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:caffe_app/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cart/logic/cart_cubit.dart';
import '../../../cart/logic/cart_state.dart';
import '../../../favorites/logic/favorites_cubit.dart';
import '../../../favorites/logic/favorites_state.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex;

  const HomeBottomNav({super.key, required this.currentIndex});

  void _onItemSelected(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = const HomeScreen();
        break;
      case 1:
        nextScreen = const FavoritesScreen();
        break;
      case 2:
        nextScreen = const CartScreen();
        break;
      case 3:
        nextScreen = const NotificationsScreen();
        break;
      default:
        return;
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => nextScreen,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BottomNavItem(
            icon: Icons.home_rounded,
            isActive: currentIndex == 0,
            onTap: () => _onItemSelected(context, 0),
          ),
          BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              return _BottomNavItem(
                icon: Icons.favorite_rounded,
                isActive: currentIndex == 1,
                badgeCount: state.items.length,
                onTap: () => _onItemSelected(context, 1),
              );
            },
          ),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              final count = state.items.fold(
                0,
                (sum, item) => sum + item.quantity,
              );
              return _BottomNavItem(
                icon: Icons.shopping_bag_rounded,
                isActive: currentIndex == 2,
                badgeCount: count,
                onTap: () => _onItemSelected(context, 2),
              );
            },
          ),
          _BottomNavItem(
            icon: Icons.notifications_rounded,
            isActive: currentIndex == 3,
            onTap: () => _onItemSelected(context, 3),
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final int badgeCount;

  const _BottomNavItem({
    required this.icon,
    required this.onTap,
    this.isActive = false,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFFC67C4E) : const Color(0xFF989898),
          ),
          if (badgeCount > 0)
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFFd47311),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  badgeCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
