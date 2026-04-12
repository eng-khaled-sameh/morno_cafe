import 'package:flutter/material.dart';

class AppFormatter {
  static String formatPrice(double price, String langCode) {
    if (langCode == 'ar') {
      final strPrice = price.toStringAsFixed(0);
      return '${toArabicNumbers(strPrice, langCode)} ج.م';
    } else {
      return 'LE ${price.toStringAsFixed(2)}';
    }
  }

  static Widget formatPriceWidget(double price, String langCode, TextStyle baseStyle) {
    if (langCode == 'ar') {
      final strPrice = price.toStringAsFixed(0);
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '${toArabicNumbers(strPrice, langCode)} ',
              style: baseStyle.copyWith(fontWeight: FontWeight.w800),
            ),
            TextSpan(
              text: 'ج.م',
              style: baseStyle.copyWith(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      );
    } else {
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'LE ',
              style: baseStyle.copyWith(fontWeight: FontWeight.w400),
            ),
            TextSpan(
              text: price.toStringAsFixed(2),
              style: baseStyle.copyWith(fontWeight: FontWeight.w800),
            ),
          ],
        ),
      );
    }
  }

  static String toArabicNumbers(String text, String langCode) {
    if (langCode != 'ar') return text;
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    String res = text;
    for (int i = 0; i < english.length; i++) {
      res = res.replaceAll(english[i], arabic[i]);
    }
    return res;
  }
}
