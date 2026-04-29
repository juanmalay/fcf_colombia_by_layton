import 'package:flutter/material.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent,
            AppColors.error.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // TEXTO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selección Colombia",
                  style: AppTextStyles.h1.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  "Noticias, partidos, jugadores y más",
                  style: AppTextStyles.body.copyWith(color: Colors.black87),
                ),
              ],
            ),
          ),

          // LOGO
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.black.withValues(alpha: 0.1),
            child: const Icon(
              Icons.sports_soccer,
              size: 40,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
