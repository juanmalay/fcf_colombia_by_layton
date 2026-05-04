import '../models/kit_model.dart';

abstract class KitsLocalDataSource {
  Future<List<KitModel>> getAllKits();
  Future<List<KitModel>> getTeamKits(String teamId);
}
