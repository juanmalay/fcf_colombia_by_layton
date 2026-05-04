import '../../domain/entities/kit.dart';
import '../../domain/repositories/kit_repository.dart';
import '../datasources/kits_local_datasource.dart';

class KitRepositoryImpl implements KitRepository {
  final KitsLocalDataSource localDataSource;

  KitRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Kit>> getKitsByTeamId(String teamId) async {
    final models = await localDataSource.getKitsByTeamId(teamId);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Kit?> getKitById(String id) async {
    final model = await localDataSource.getKitById(id);
    return model?.toEntity();
  }
}
