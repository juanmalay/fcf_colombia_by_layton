import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_text_styles.dart';

/// Pantalla de exploración (torneos, noticias, jugadores)
class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explorar'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Torneos Section
            Text(
              'Torneos',
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildExploreCard('Eliminatoria 2026', 'Clasificación de la CONMEBOL'),
            const SizedBox(height: AppSpacing.md),
            _buildExploreCard('Copa América 2024', 'Torneo continental más importante'),
            const SizedBox(height: AppSpacing.lg),
            
            // Noticias Section
            Text(
              'Últimas Noticias',
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildNewsCard('Novedades en la selección', 'Actualizaciones y comunicados'),
            const SizedBox(height: AppSpacing.md),
            _buildNewsCard('Análisis de partidos', 'Reportes técnicos y estadísticas'),
            const SizedBox(height: AppSpacing.lg),
            
            // Jugadores destacados
            Text(
              'Jugadores Destacados',
              style: AppTextStyles.h2,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildPlayerCard('James Rodríguez', 'Mediocampista'),
            const SizedBox(height: AppSpacing.md),
            _buildPlayerCard('Radamel Falcao', 'Delantero'),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreCard(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.h3),
          const SizedBox(height: AppSpacing.sm),
          Text(subtitle, style: AppTextStyles.body),
        ],
      ),
    );
  }

  Widget _buildNewsCard(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.h3),
          const SizedBox(height: AppSpacing.sm),
          Text(description, style: AppTextStyles.caption),
        ],
      ),
    );
  }

  Widget _buildPlayerCard(String name, String position) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primary,
            child: Text(
              name.characters.first,
              style: AppTextStyles.h1.copyWith(color: AppColors.accent),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppTextStyles.label),
              Text(position, style: AppTextStyles.caption),
            ],
          ),
        ],
      ),
    );
  }
}
