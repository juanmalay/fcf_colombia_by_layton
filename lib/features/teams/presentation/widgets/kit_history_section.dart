import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_text_styles.dart';
import '../../../favorites/presentation/providers/favorites_providers.dart';
import '../providers/kit_providers.dart';
import 'kit_card.dart';

class KitHistorySection extends ConsumerWidget {
  final String teamId;

  const KitHistorySection({
    super.key,
    required this.teamId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kitsState = ref.watch(teamKitsProvider(teamId));
    final favorites = ref.watch(favoritesProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.border,
            width: 0.8,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Historial de camisetas',
                    style: AppTextStyles.h3,
                  ),
                ),
                Text(
                  'Max. 3',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Selección de camisetas registradas para este equipo.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            kitsState.when(
              loading: () => const _KitHistoryLoadingState(),
              error: (error, stackTrace) => _KitHistoryErrorState(
                onRetry: () => ref.refresh(teamKitsProvider(teamId)),
              ),
              data: (kits) {
                if (kits.isEmpty) {
                  return const _KitHistoryEmptyState();
                }

                final visibleKits = kits.take(3).toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...visibleKits.map((kit) {
                      final favoriteId = 'kit:${kit.id}';
                      return KitCard(
                        kit: kit,
                        isFavorite: favorites.contains(favoriteId),
                        onToggleFavorite: () {
                          ref.read(favoritesProvider.notifier).toggle(favoriteId);
                        },
                      );
                    }),
                    const SizedBox(height: 4),
                    Text(
                      kits.length > 3
                          ? 'Ver historia completa'
                          : 'Más camisetas disponibles próximamente.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _KitHistoryLoadingState extends StatelessWidget {
  const _KitHistoryLoadingState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _KitHistoryErrorState extends StatelessWidget {
  final VoidCallback onRetry;

  const _KitHistoryErrorState({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'No se pudo cargar el historial de camisetas.',
          style: AppTextStyles.body.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: onRetry,
          child: const Text('Reintentar'),
        ),
      ],
    );
  }
}

class _KitHistoryEmptyState extends StatelessWidget {
  const _KitHistoryEmptyState();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'No hay camisetas registradas para este equipo.',
          style: AppTextStyles.body.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Podrás ver más histórico cuando se amplíe el catálogo.',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
