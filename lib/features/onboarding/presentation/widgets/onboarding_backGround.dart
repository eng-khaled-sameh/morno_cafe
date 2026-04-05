import 'package:flutter/material.dart';

class OnboardingBackGround extends StatelessWidget {
  const OnboardingBackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.67,
        width: double.infinity,
        child: Image.asset(
          'assets/images/image_3.png',
          fit: BoxFit.cover,
          alignment: const Alignment(-0.15, -0.55),
        ),
      ),
    );
  }
}
