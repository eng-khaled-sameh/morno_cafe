import 'package:caffe_app/features/home/presentation/screens/home_screen.dart';
import 'package:caffe_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:caffe_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:caffe_app/features/cart/logic/cart_cubit.dart';
import 'package:caffe_app/features/favorites/logic/favorites_cubit.dart';
import 'package:caffe_app/features/home/logic/home_cubit.dart';
import 'package:caffe_app/core/services/auth_service.dart';
import 'package:caffe_app/core/logic/auth_cubit.dart';
import 'package:caffe_app/core/logic/auth_state.dart';
import 'package:caffe_app/features/search/logic/search_cubit.dart';
import 'package:caffe_app/core/logic/language_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthCubit(AuthService.instance)..checkAuthState(),
        ),
        BlocProvider(create: (context) => LanguageCubit()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(
          create: (context) => SearchCubit(context.read<HomeCubit>()),
        ),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => FavoritesCubit()),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            locale: locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            navigatorKey: _navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Sora'),
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: BlocListener<AuthCubit, AuthState>(
                  listenWhen: (previous, current) =>
                      (current is AuthUnauthenticated &&
                          previous is AuthAuthenticated) ||
                      (current is AuthAuthenticated &&
                          previous is AuthUnauthenticated),
                  listener: (context, state) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (state is AuthUnauthenticated) {
                        _navigatorKey.currentState?.pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const OnboardingScreen(),
                          ),
                          (route) => false,
                        );
                      } else if (state is AuthAuthenticated) {
                        _navigatorKey.currentState?.pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    });
                  },
                  child: child ?? const SizedBox.shrink(),
                ),
              );
            },
            home: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  return const HomeScreen();
                }
                return const OnboardingScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
