import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_text_styles.dart';
import '../providers/favorites_providers.dart';

class FavoriteCandidate {
  final String id;
  final String title;
  final String subtitle;

  const FavoriteCandidate(this.id, this.title, this.subtitle);
}

const _matchFavorites = [
  FavoriteCandidate('match-1', 'Colombia vs Argentina', 'Eliminatorias 2026'),
  FavoriteCandidate('match-2', 'Colombia vs Peru', 'Amistoso Internacional'),
];

const _playerFavorites = [
  FavoriteCandidate('player-1', 'James Rodriguez', 'Mediocampista'),
  FavoriteCandidate('player-2', 'Radamel Falcao', 'Delantero'),
];

const _newsFavorites = [
  FavoriteCandidate('news-1', 'Novedades de la seleccion', 'Comunicado'),
  FavoriteCandidate('news-2', 'Analisis de partidos', 'Reporte tecnico'),
];

/// Pantalla de favoritos con persistencia local.
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Favoritos'),
        centerTitle: true,
      ),
      body: const DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              indicatorColor: AppColors.accent,
              indicatorWeight: 3,
              labelStyle: AppTextStyles.label,
              tabs: [
                Tab(text: 'Partidos'),
                Tab(text: 'Jugadores'),
                Tab(text: 'Noticias'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _FavoritesTab(items: _matchFavorites),
                  _FavoritesTab(items: _playerFavorites),
                  _FavoritesTab(items: _newsFavorites),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoritesTab extends ConsumerWidget {
  final List<FavoriteCandidate> items;

  const _FavoritesTab({required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final isFavorite = favorites.contains(item.id);

        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: isFavorite ? 0.15 : 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.accent.withValues(alpha: isFavorite ? 0.5 : 0.2),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: AppTextStyles.h3),
                    const SizedBox(height: AppSpacing.sm),
                    Text(item.subtitle, style: AppTextStyles.caption),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  ref.read(favoritesProvider.notifier).toggle(item.id);
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
