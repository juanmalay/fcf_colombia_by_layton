import '../entities/kit.dart';
import '../repositories/kit_repository.dart';

class GetTeamKitsUseCase {
  final KitRepository repository;

  GetTeamKitsUseCase(this.repository);

  Future<List<Kit>> call(String teamId) async {
    return repository.getTeamKits(teamId);
  }
}
