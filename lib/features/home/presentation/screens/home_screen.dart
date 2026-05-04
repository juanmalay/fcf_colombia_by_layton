import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_text_styles.dart';
import '../../../matches/presentation/providers/match_providers.dart';

/// Pantalla de inicio con resumen conectado al modulo Matches.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final upcomingState = ref.watch(upcomingMatchesProvider);
    final recentState = ref.watch(recentMatchesProvider);

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
            upcomingState.when(
              loading: () => _HomePanel(
                title: 'Proximo partido',
                value: 'Cargando...',
                color: AppColors.primary,
              ),
              error: (_, __) => _HomePanel(
                title: 'Proximo partido',
                value: 'No disponible',
                color: AppColors.primary,
              ),
              data: (matches) {
                final match = matches.isNotEmpty ? matches.first : null;
                return _HomePanel(
                  title: 'Proximo partido',
                  value: match?.title ?? 'Sin partidos programados',
                  subtitle: match?.tournament,
                  color: AppColors.primary,
                );
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Resultados Recientes', style: AppTextStyles.h3),
            const SizedBox(height: AppSpacing.md),
            recentState.when(
              loading: () => const _CompactPanel(text: 'Cargando resultados...'),
              error: (_, __) =>
                  const _CompactPanel(text: 'Resultados no disponibles'),
              data: (matches) {
                final match = matches.isNotEmpty ? matches.first : null;
                return _CompactPanel(
                  text: match == null
                      ? 'Sin resultados recientes'
                      : '${match.title} - ${match.scoreDisplay}',
                );
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Noticias', style: AppTextStyles.h3),
            const SizedBox(height: AppSpacing.md),
            const _CompactPanel(text: 'Noticias pendientes de integracion'),
          ],
        ),
      ),
    );
  }
}

class _HomePanel extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final Color color;

  const _HomePanel({
    required this.title,
    required this.value,
    this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.caption.copyWith(color: AppColors.textInverse),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: AppTextStyles.h2.copyWith(color: AppColors.textInverse),
            textAlign: TextAlign.center,
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle!,
              style: AppTextStyles.body.copyWith(color: AppColors.textInverse),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

class _CompactPanel extends StatelessWidget {
  final String text;

  const _CompactPanel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          text,
          style: AppTextStyles.body,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
