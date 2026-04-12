import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caffe_app/core/logic/language_cubit.dart';
import 'package:caffe_app/core/logic/auth_cubit.dart';
import 'package:caffe_app/core/logic/auth_state.dart';
import 'package:caffe_app/core/theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffe_app/core/utils/app_formatter.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.watch<LanguageCubit>().state.languageCode == 'ar';
    
    return Drawer(
      backgroundColor: const Color(0xFF131313),
      child: SafeArea(
        child: Column(
          children: [
            // Top Logo
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 8),
              child: Image.asset(
                'assets/images/logo-3.png',
                height: 70,
                fit: BoxFit.contain,
              ),
            ),
            
            // Header with Profile and Language
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is AuthAuthenticated) {
                  final user = authState.user;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Profile Picture
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2A2A),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFE5B976),
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: user.photoURL != null
                                ? CachedNetworkImage(
                                    imageUrl: user.photoURL!,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                    size: 28,
                                  ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // User Name
                        Expanded(
                          child: Text(
                            user.displayName ?? 'User',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // Language Switcher
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => context.read<LanguageCubit>().toggle(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: BlocBuilder<LanguageCubit, Locale>(
                              builder: (context, locale) {
                                final isAr = locale.languageCode == 'ar';
                                return Directionality(
                                  textDirection: isAr
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  child: Text(
                                    isAr ? 'English' : 'عربي',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            Divider(color: Colors.white.withOpacity(0.1), thickness: 1),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 12),
                children: [
                  // Products List
                  _buildDrawerItem(
                    icon: Icons.coffee_rounded,
                    title: isArabic ? 'قائمة المنتجات' : 'Products List',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  // Offers
                  _buildDrawerItem(
                    icon: Icons.local_offer_rounded,
                    title: isArabic ? 'العروض' : 'Offers',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 16),
                  Divider(color: Colors.white.withOpacity(0.1), thickness: 1),
                  const SizedBox(height: 16),

                  // Store Info
                  _buildInfoItem(
                    icon: Icons.location_on_rounded,
                    title: isArabic ? 'عنوان المحل' : 'Store Address',
                    subtitle: isArabic 
                      ? 'الشرقية - ديرب نجم - بجوار الحصان امام شركة الماء'
                      : 'Al-Sharqia - Diarb Negm - Next to El-Hossan, Front of Water Company',
                  ),
                  const SizedBox(height: 16),
                  _buildInfoItem(
                    icon: Icons.phone_rounded,
                    title: isArabic ? 'رقم هاتف المكان' : 'Store Phone',
                    subtitle: AppFormatter.toArabicNumbers('01022902989', context.read<LanguageCubit>().state.languageCode),
                  ),
                ],
              ),
            ),

            // Logout Button
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context); // Close Drawer
                    context.read<AuthCubit>().signOut();
                  },
                  icon: const Icon(Icons.logout_rounded, color: Colors.white),
                  label: Text(
                    isArabic ? 'تسجيل الخروج' : 'Logout',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 24),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.white, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
