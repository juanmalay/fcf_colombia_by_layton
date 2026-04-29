import '../entities/match.dart';
import '../repositories/match_repository.dart';

/// UseCase: Obtener resultados recientes
class GetRecentMatchesUseCase {
  final MatchRepository repository;

  GetRecentMatchesUseCase(this.repository);

  Future<List<Match>> call() async {
    return await repository.getRecentMatches();
  }
}
