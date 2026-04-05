import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextOnboarding1 extends StatelessWidget {
  const TextOnboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 336,
      child: Text(
        'Coffee so good,\nyour taste buds\nwill love it.',
        textAlign: TextAlign.center,
        style: GoogleFonts.sora(
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
