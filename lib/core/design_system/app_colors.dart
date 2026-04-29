import 'package:flutter/material.dart';

/// Paleta de colores del proyecto
/// Concepto: "Moderno Colombiano" - Claro, energético, profesional
class AppColors {
  // Primary Colors - Azul colombiano
  static const Color primary = Color(0xFF14213D); // Azul profundo
  static const Color primaryLight = Color(0xFF2A3F5F);
  static const Color primaryDark = Color(0xFF0D1629);

  // Accent Colors - Amarillo colombiano energético
  static const Color accent = Color(0xFFFCA311); // Amarillo vibrante
  static const Color accentLight = Color(0xFFFFB84D);
  static const Color accentDark = Color(0xFFE08A0A);

  // Secondary Colors
  static const Color error = Color(0xFFDC2626); // Rojo claro
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);

  // Neutral Colors - Light theme
  static const Color surface = Color(0xFFF8F9FB); // Fondo principal ligero
  static const Color background = Color(0xFFFFFFFF); // Blanco puro para cards
  static const Color surfaceVariant = Color(0xFFF3F4F6);

  // Text Colors
  static const Color textPrimary = Color(0xFF1F2937); // Texto oscuro
  static const Color textSecondary = Color(0xFF6B7280); // Texto secundario
  static const Color textTertiary = Color(0xFF9CA3AF); // Texto terciario
  static const Color textInverse = Color(0xFFFFFFFF);

  // Neutral Grays - Light theme
  static const Color gray900 = Color(0xFF111827);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray50 = Color(0xFFF9FAFB);

  // Borders & Dividers - Light theme
  static const Color divider = Color(0xFFE5E7EB); // Bordes suaves
  static const Color border = Color(0xFFE5E7EB);

  // Shadows (for elevation)
  static const Color shadowColor = Color(0x0F000000); // Sombra ligera

  // Deprecated - kept for reference
  static const Color navy = Color(0xFF14213D);
  static const Color lightGray = Color(0xFFF3F4F6);
}
