import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/match.dart';
import '../../domain/repositories/match_repository.dart';
import '../../domain/usecases/get_upcoming_matches_usecase.dart';
import '../../domain/usecases/get_recent_matches_usecase.dart';
import '../../domain/usecases/get_match_detail_usecase.dart'; 
import '../../data/datasources/matches_local_datasource.dart';
import '../../data/datasources/matches_local_datasource_impl.dart';
import '../../data/datasources/matches_remote_datasource.dart';
import '../../data/datasources/matches_remote_datasource_impl.dart';
import '../../data/repositories/match_repository_impl.dart';
import '../../../../core/providers/app_providers.dart';

// ============================================================================
// DATASOURCES
// ============================================================================

/// Provider del datasource remoto (API)
final matchesRemoteDataSourceProvider = Provider<MatchesRemoteDataSource>((ref) {
  final dio = ref.watch(dioServiceProvider);
  return MatchesRemoteDataSourceImpl(dio);
});

/// Provider del datasource local (caché)
final matchesLocalDataSourceProvider = Provider<MatchesLocalDataSource>((ref) {
  return MatchesLocalDataSourceImpl();
});

// ============================================================================
// REPOSITORY
// ============================================================================

/// Provider del repositorio de partidos
/// Inyecta ambos datasources automaticamente
final matchRepositoryProvider = Provider<MatchRepository>((ref) {
  return MatchRepositoryImpl(
    remoteDataSource: ref.watch(matchesRemoteDataSourceProvider),
    localDataSource: ref.watch(matchesLocalDataSourceProvider),
  );
});

// ============================================================================
// USECASES
// ============================================================================

/// Provider del usecase: obtener partidos próximos
final getUpcomingMatchesUseCaseProvider = Provider((ref) {
  return GetUpcomingMatchesUseCase(ref.watch(matchRepositoryProvider));
});

/// Provider del usecase: obtener resultados recientes
final getRecentMatchesUseCaseProvider = Provider((ref) {
  return GetRecentMatchesUseCase(ref.watch(matchRepositoryProvider));
});

/// Provider del usecase: obtener detalle de partido
final getMatchDetailUseCaseProvider = Provider((ref) {
  return GetMatchDetailUseCase(ref.watch(matchRepositoryProvider));
});

// ============================================================================
// STATE: UPCOMING MATCHES
// ============================================================================

/// Notifier para estado de partidos próximos
class UpcomingMatchesNotifier extends AutoDisposeAsyncNotifier<List<Match>> {
  @override
  Future<List<Match>> build() async {
    final useCase = ref.watch(getUpcomingMatchesUseCaseProvider);
    return await useCase();
  }

  /// Fuerza actualización manual
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }
}

/// Provider de estado: partidos próximos
final upcomingMatchesProvider =
    AutoDisposeAsyncNotifierProvider<UpcomingMatchesNotifier, List<Match>>(
  () => UpcomingMatchesNotifier(),
);

// ============================================================================
// STATE: RECENT MATCHES
// ============================================================================

/// Notifier para estado de resultados recientes
class RecentMatchesNotifier extends AutoDisposeAsyncNotifier<List<Match>> {
  @override
  Future<List<Match>> build() async {
    final useCase = ref.watch(getRecentMatchesUseCaseProvider);
    return await useCase();
  }

  /// Fuerza actualización manual
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }
}

/// Provider de estado: resultados recientes
final recentMatchesProvider =
    AutoDisposeAsyncNotifierProvider<RecentMatchesNotifier, List<Match>>(
  () => RecentMatchesNotifier(),
);

// ============================================================================
// STATE: MATCH DETAIL
// ============================================================================

/// Notifier para estado del detalle de partido
class MatchDetailNotifier
    extends AutoDisposeFamilyAsyncNotifier<Match?, String> {
  @override
  Future<Match?> build(String matchId) async {
    final useCase = ref.watch(getMatchDetailUseCaseProvider);
    return await useCase(matchId);
  }

  /// Fuerza actualización manual
  Future<void> refresh(String matchId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build(matchId));
  }
}

/// Provider de estado: detalle de un partido
/// Requiere pasar el matchId en la llamada
final matchDetailProvider = AutoDisposeAsyncNotifierProvider.family<
    MatchDetailNotifier,
    Match?,
    String>(
  () => MatchDetailNotifier(),
);

// ============================================================================
// FILTER: TOURNAMENT
// ============================================================================

/// Provider para filtrar por torneo
final selectedTournamentProvider = StateProvider.autoDispose<String?>(
  (ref) => null,
);

/// Provider de partidos filtrados por torneo
final matchesByTournamentProvider =
    FutureProvider.autoDispose<List<Match>>((ref) async {
  final tournament = ref.watch(selectedTournamentProvider);
  if (tournament == null || tournament.isEmpty) {
    return [];
  }
  final repository = ref.watch(matchRepositoryProvider);
  return repository.getMatchesByTournament(tournament);
});

// ============================================================================
// FILTER: TEAM
// ============================================================================

/// Provider para filtrar por equipo
final selectedTeamProvider = StateProvider.autoDispose<String?>(
  (ref) => null,
);

/// Provider de partidos filtrados por equipo
final matchesByTeamProvider = FutureProvider.autoDispose<List<Match>>((ref) async {
  final team = ref.watch(selectedTeamProvider);
  if (team == null || team.isEmpty) {
    return [];
  }
  final repository = ref.watch(matchRepositoryProvider);
  return repository.getMatchesByTeam(team);
});
