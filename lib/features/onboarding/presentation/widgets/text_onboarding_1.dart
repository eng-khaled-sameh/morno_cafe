import 'package:caffe_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';


class TextOnboarding1 extends StatelessWidget {
  const TextOnboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 336,
      child: Text(
        AppLocalizations.of(context)!.onboardingTitle.replaceAll(', ', ',\n').replaceAll('buds ', 'buds\n'),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.34,
          color: Colors.white,
          height: 1.15,
        ),
      ),
    );
  }
}
