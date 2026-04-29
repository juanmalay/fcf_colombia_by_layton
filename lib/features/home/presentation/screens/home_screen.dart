import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_text_styles.dart';

/// Pantalla de inicio
class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FCF Colombia'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Próximo Partido',
                  style: AppTextStyles.h2.copyWith(
                    color: AppColors.textInverse,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Recent Results Section
            Text(
              'Resultados Recientes',
              style: AppTextStyles.h3,
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              height: 100,
              color: AppColors.primary.withValues(alpha: 0.1),
              child: const Center(
                child: Text('Carrusel de resultados'),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // News Section
            Text(
              'Noticias',
              style: AppTextStyles.h3,
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              height: 100,
              color: AppColors.accent.withValues(alpha: 0.1),
              child: const Center(
                child: Text('Feed de noticias'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
