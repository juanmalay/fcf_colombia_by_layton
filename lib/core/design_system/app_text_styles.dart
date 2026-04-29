import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Estilos de texto del proyecto
/// Usa 2 tipografías: Inter (body) y Roboto Mono (datos)
class AppTextStyles {
  // Heading 1: 32px, bold, leading 1.2
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );

  // Heading 2: 24px, semibold, leading 1.3
  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: -0.2,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );

  // Heading 3: 18px, semibold, leading 1.4
  static const TextStyle h3 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );

  // Body: 14px, regular, leading 1.5
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );

  // Body Large: 16px, regular, leading 1.5
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );

  // Body Small: 12px, regular, leading 1.4
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.4,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );

  // Caption: 12px, regular, leading 1.4
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.4,
    color: AppColors.textSecondary,
    fontFamily: 'Inter',
  );

  // Label: 12px, semibold
  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
  );

  // Button: 14px, semibold
  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.textInverse,
    fontFamily: 'Inter',
  );

  // Data/Numbers: Roboto Mono (precisión deportiva)
  static const TextStyle dataLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto Mono',
    color: AppColors.textPrimary,
  );

  static const TextStyle data = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: 'Roboto Mono',
    color: AppColors.textPrimary,
  );

  static const TextStyle dataSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto Mono',
    color: AppColors.textSecondary,
  );

  // Secondary text versions
  static TextStyle get bodySecondary => body.copyWith(color: AppColors.textSecondary);
  static TextStyle get bodySmallSecondary => bodySmall.copyWith(color: AppColors.textSecondary);

  // Error text
  static const TextStyle errorText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
    fontFamily: 'Inter',
  );
}
