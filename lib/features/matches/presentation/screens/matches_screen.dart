import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/design_system/app_colors.dart';
import '../../../../core/design_system/app_spacing.dart';
import '../../../../core/design_system/app_text_styles.dart';
import '../../domain/entities/match.dart' as match_entity;
import '../providers/match_providers.dart';
import '../../../favorites/presentation/providers/favorites_providers.dart';
import '../widgets/match_card.dart';

class MatchesScreen extends ConsumerWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Partidos'),
          centerTitle: true,
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Próximos'),
              Tab(text: 'Resultados'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _UpcomingTab(),
            _ResultsTab(),
          ],
        ),
      ),
    );
  }
}

class _UpcomingTab extends ConsumerWidget {
  const _UpcomingTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final upcomingState = ref.watch(upcomingMatchesProvider);

    return upcomingState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => const Center(
        child: Text('Error cargando partidos próximos'),
      ),
      data: (matches) => matches.isEmpty
          ? const Center(
              child: Text('No hay partidos próximos en este momento'),
            )
          : ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];
                final favoriteId = 'match:${match.id}';
                return MatchCard(
                  match: match,
                  isFavorite: favorites.contains(favoriteId),
                  onFavoriteTap: () =>
                      ref.read(favoritesProvider.notifier).toggle(favoriteId),
                  onTap: () => context.push('/matches/${match.id}'),
                );
              },
            ),
    );
  }
}

class _ResultsTab extends ConsumerWidget {
  const _ResultsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);
    final recentState = ref.watch(recentMatchesProvider);

    return recentState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => const Center(
        child: Text('Error cargando resultados recientes'),
      ),
      data: (matches) => matches.isEmpty
          ? const Center(
              child: Text('No hay resultados recientes en este momento'),
            )
          : ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];
                final favoriteId = 'match:${match.id}';
                return MatchCard(
                  match: match,
                  isFavorite: favorites.contains(favoriteId),
                  onFavoriteTap: () =>
                      ref.read(favoritesProvider.notifier).toggle(favoriteId),
                  onTap: () => context.push('/matches/${match.id}'),
                );
              },
            ),
    );
  }
}
