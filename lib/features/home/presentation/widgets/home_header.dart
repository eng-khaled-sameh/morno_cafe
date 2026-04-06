import 'package:caffe_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caffe_app/core/logic/auth_cubit.dart';
import 'package:caffe_app/core/logic/auth_state.dart';
import 'package:caffe_app/core/logic/language_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          final user = state.user;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.welcome,
                          style: GoogleFonts.sora(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            letterSpacing: -0.24,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              user.displayName ??
                                  AppLocalizations.of(context)!.user,
                              style: GoogleFonts.sora(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFDDDDDD),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        AppLocalizations.of(context)!.signOut,
                                      ),
                                      content: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.signOutConfirmation,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.cancel,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            context.read<AuthCubit>().signOut();
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!.ok,
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.logout_rounded,
                                size: 18,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<LanguageCubit>().toggle();
                          },
                          child: BlocBuilder<LanguageCubit, Locale>(
                            builder: (context, locale) {
                              final isArabic = locale.languageCode == 'ar';
                              return Text(
                                isArabic ? 'English' : 'عربي',
                                style: GoogleFonts.sora(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: user.photoURL != null
                                ? CachedNetworkImage(
                                    imageUrl: user.photoURL!,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.person, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
