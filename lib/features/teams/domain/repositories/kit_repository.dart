import '../entities/kit.dart';

abstract class KitRepository {
  Future<List<Kit>> getTeamKits(String teamId);
}
