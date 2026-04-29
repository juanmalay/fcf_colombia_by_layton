import '../entities/match.dart';
import '../repositories/match_repository.dart';

/// UseCase: Obtener detalle de un partido
class GetMatchDetailUseCase {
  final MatchRepository repository;

  GetMatchDetailUseCase(this.repository);

  Future<Match?> call(String matchId) async {
    return await repository.getMatchDetail(matchId);
  }
}
