import '../entities/team.dart';
import '../repositories/team_repository.dart';

/// UseCase: Obtener todos los equipos
class GetTeamsUseCase {
  final TeamRepository repository;

  GetTeamsUseCase(this.repository);

  Future<List<Team>> call() async {
    return await repository.getAllTeams();
  }
}
