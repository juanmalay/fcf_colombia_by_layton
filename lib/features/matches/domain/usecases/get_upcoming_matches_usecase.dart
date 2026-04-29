import '../entities/match.dart';
import '../repositories/match_repository.dart';

/// UseCase: Obtener partidos próximos
/// Encapsula la lógica de negocio de obtener partidos próximos
class GetUpcomingMatchesUseCase {
  final MatchRepository repository;

  GetUpcomingMatchesUseCase(this.repository);

  Future<List<Match>> call() async {
    return await repository.getUpcomingMatches();
  }
}
