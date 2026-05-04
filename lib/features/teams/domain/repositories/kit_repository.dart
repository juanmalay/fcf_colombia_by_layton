import '../entities/kit.dart';

abstract class KitRepository {
  Future<List<Kit>> getKitsByTeamId(String teamId);

  Future<Kit?> getKitById(String id);
}
