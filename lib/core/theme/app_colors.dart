import 'package:flutter/material.dart';

abstract class AppColors {
  // ── Primary ──────────────────────────────
  static const primary = Color(0xFFd47311);
  static const primaryLight = Color(0xFFE8A05A);
  static const primaryDark = Color(0xFFB85E0A);

  // ── Neutral ──────────────────────────────
  static const dark = Color(0xFF1B242D);
  static const grey = Color(0xFF6B7280);
  static const greyLight = Color(0xFFD1D5DB);

  // ── Background ───────────────────────────
  static const background = Color(0xFFF9F9F9);
  static const surface = Color(0xFFFFFFFF);

  // ── Status ───────────────────────────────
  static const success = Color(0xFF22C55E);
  static const error = Color(0xFFEF4444);
  static const warning = Color(0xFFF59E0B);
  static const info = Color(0xFF3B82F6);

  // ── Text ─────────────────────────────────
  static const textPrimary = Color(0xFF1B242D);
  static const textSecondary = Color(0xFF6B7280);
  static const textHint = Color(0xFFD1D5DB);
}
