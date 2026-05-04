import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fcf_colombia_by_layton/features/matches/presentation/providers/match_providers.dart';
import 'package:fcf_colombia_by_layton/features/favorites/presentation/providers/favorites_providers.dart';

class MatchDetailScreen extends ConsumerWidget {
  final String matchId;

  const MatchDetailScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchState = ref.watch(matchDetailProvider(matchId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del partido'),
      ),
      body: matchState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              ElevatedButton(
                onPressed: () => ref.read(matchDetailProvider(matchId).notifier).refresh(matchId),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
        data: (match) {
          if (match == null) {
            return const Center(child: Text('Partido no encontrado'));
          }

          final favorites = ref.watch(favoritesProvider);
          final favoriteId = 'match:${match.id}';
          final isFavorite = favorites.contains(favoriteId);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('${match.homeTeam.name} vs ${match.awayTeam.name}'),
                  subtitle: Text('${match.tournament} - ${match.matchDate}'),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () => ref.read(favoritesProvider.notifier).toggle(favoriteId),
                  ),
                ),
                ListTile(
                  title: const Text('Estadio'),
                  subtitle: Text(match.venue),
                ),
                ListTile(
                  title: const Text('Árbitro'),
                  subtitle: Text(match.referee),
                ),
                ListTile(
                  title: const Text('Estado del partido'),
                  subtitle: Text(match.status.toDisplayString()),
                ),
                const Divider(),
                DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      const TabBar(
                        tabs: [
                          Tab(text: 'Resumen'),
                          Tab(text: 'Estadísticas'),
                          Tab(text: 'Eventos'),
                        ],
                      ),
                      SizedBox(
                        height: 300,
                        child: TabBarView(
                          children: [
                            const Center(child: Text('Resumen no disponible')),
                            match.statistics?.isEmpty ?? true
                                ? const Center(child: Text('Estadísticas no disponibles'))
                                : Column(
                                  children: match.statistics!.map((stat) => Text('${stat.name}: ${stat.value}')).toList(),
                                ),
                            match.events?.isEmpty ?? true
                                ? const Center(child: Text('Eventos no disponibles'))
                                : Column(
                                  children: match.events!.map((event) => Text('${event.time} - ${event.description}')).toList(),
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
