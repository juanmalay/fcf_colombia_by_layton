import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/app_providers.dart';
import '../../data/datasources/teams_local_datasource.dart';
import '../../data/datasources/teams_local_datasource_impl.dart';
import '../../data/datasources/teams_remote_datasource.dart';
import '../../data/datasources/teams_remote_datasource_impl.dart';
import '../../data/repositories/team_repository_impl.dart';
import '../../domain/entities/team.dart';
import '../../domain/repositories/team_repository.dart';
import '../../domain/usecases/get_teams_usecase.dart';
import '../../domain/usecases/get_team_detail_usecase.dart';

/// Provider para TeamsRemoteDataSource
final teamsRemoteDataSourceProvider = Provider<TeamsRemoteDataSource>((ref) {
  final dioService = ref.watch(dioServiceProvider);
  return TeamsRemoteDataSourceImpl(dioService);
});

/// Provider para TeamsLocalDataSource
final teamsLocalDataSourceProvider = Provider<TeamsLocalDataSource>((ref) {
  return TeamsLocalDataSourceImpl();
});

/// Provider para TeamRepository
final teamRepositoryProvider = Provider<TeamRepository>((ref) {
  return TeamRepositoryImpl(
    remoteDataSource: ref.watch(teamsRemoteDataSourceProvider),
    localDataSource: ref.watch(teamsLocalDataSourceProvider),
  );
});

/// Provider para GetTeamsUseCase
final getTeamsUseCaseProvider = Provider((ref) {
  return GetTeamsUseCase(ref.watch(teamRepositoryProvider));
});

/// Provider para GetTeamDetailUseCase
final getTeamDetailUseCaseProvider = Provider((ref) {
  return GetTeamDetailUseCase(ref.watch(teamRepositoryProvider));
});

/// Provider para obtener todos los equipos
final teamsProvider = FutureProvider<List<Team>>((ref) async {
  final useCase = ref.watch(getTeamsUseCaseProvider);
  return useCase();
});

/// Provider para obtener detalles de un equipo específico
final teamDetailProvider = FutureProvider.family<Team?, String>((ref, teamId) async {
  final useCase = ref.watch(getTeamDetailUseCaseProvider);
  return useCase(teamId);
});
