import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_spacing.dart';

/// Tema de la aplicación: Material 3 + Identidad Colombiana
class AppTheme {
  // Light Theme (primary)
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Color scheme
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColors.primary,
      secondary: AppColors.accent,
      tertiary: AppColors.error,
      surface: AppColors.surface,
      error: AppColors.error,
    ),

    // Scaffold background
    scaffoldBackgroundColor: AppColors.surface,

    // App Bar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.textInverse,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.h3.copyWith(
        color: AppColors.textInverse,
      ),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: AppColors.background,
      elevation: 2,
      shadowColor: AppColors.shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border, width: 0.5),
      ),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textInverse,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        textStyle: AppTextStyles.button,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        textStyle: AppTextStyles.button.copyWith(color: AppColors.primary),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTextStyles.button,
      ),
    ),

    // Input Fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.background,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.border, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.border, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      hintStyle: AppTextStyles.bodySecondary.copyWith(
        color: AppColors.textTertiary,
      ),
      labelStyle: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
    ),

    // Bottom Navigation
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textTertiary,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    // Chips
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.surfaceVariant,
      selectedColor: AppColors.primary,
      labelStyle: AppTextStyles.body,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 0,
    ),

    // Progress Indicators
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.accent,
    ),
  );

  // Dark Theme (deprecated - kept for reference)
  @Deprecated('Use lightTheme instead')
  static final ThemeData darkTheme = lightTheme;
}
