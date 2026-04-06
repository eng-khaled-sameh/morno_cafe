import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:caffe_app/core/widgets/custom_app_bar.dart';
import 'package:caffe_app/features/favorites/presentation/widgets/favorite_item_card.dart';
import 'package:caffe_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caffe_app/features/home/presentation/widgets/home_bottom_nav.dart';
import '../../logic/favorites_cubit.dart';
import '../../logic/favorites_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.favorites),
      bottomNavigationBar: const HomeBottomNav(currentIndex: 1),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: AppColors.greyLight,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No favorites yet',
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
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: state.items.length,
            itemBuilder: (_, index) =>
                FavoriteItemCard(item: state.items[index]),
          );
        },
      ),
    );
  }
}
