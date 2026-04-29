import '../entities/team.dart';
import '../repositories/team_repository.dart';

/// UseCase: Obtener detalles de un equipo
class GetTeamDetailUseCase {
  final TeamRepository repository;

  GetTeamDetailUseCase(this.repository);

  Future<Team?> call(String id) async {
    return await repository.getTeamDetail(id);
  }
}
