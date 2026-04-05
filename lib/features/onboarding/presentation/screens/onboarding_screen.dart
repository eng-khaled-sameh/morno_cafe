import 'package:caffe_app/features/onboarding/presentation/widgets/google_sign_In.dart';
import 'package:caffe_app/features/onboarding/presentation/widgets/onboarding_backGround.dart';
import 'package:caffe_app/features/onboarding/presentation/widgets/text_onboarding_1.dart';
import 'package:caffe_app/features/onboarding/presentation/widgets/text_onboarding_2.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const OnboardingBackGround(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 362,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const Spacer(),
                  const TextOnboarding1(),
                  const SizedBox(height: 18),
                  const TextOnboarding2(),
                  const SizedBox(height: 18),
                  const GoogleSignIn(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
