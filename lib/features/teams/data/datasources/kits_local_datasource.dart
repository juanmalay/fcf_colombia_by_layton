import '../models/kit_model.dart';

abstract class KitsLocalDataSource {
  Future<List<KitModel>> getKits();

  Future<List<KitModel>> getKitsByTeamId(String teamId);

  Future<KitModel?> getKitById(String id);
}
