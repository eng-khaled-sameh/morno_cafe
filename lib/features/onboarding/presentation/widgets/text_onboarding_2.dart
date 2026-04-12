import 'package:caffe_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';


class TextOnboarding2 extends StatelessWidget {
  const TextOnboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 314,
      child: Text(
        AppLocalizations.of(context)!.onboardingSubtitle.replaceAll('the p', '\nthe p'),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.14,
          height: 1.54,
          color: Color(0xFFA9A9A9),
        ),
      ),
    );
  }
}
