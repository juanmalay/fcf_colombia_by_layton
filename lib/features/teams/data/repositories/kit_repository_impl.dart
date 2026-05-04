import '../../domain/entities/kit.dart';
import '../../domain/repositories/kit_repository.dart';
import '../datasources/kits_local_datasource.dart';

class KitRepositoryImpl implements KitRepository {
  final KitsLocalDataSource localDataSource;

  KitRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Kit>> getTeamKits(String teamId) async {
    final models = await localDataSource.getTeamKits(teamId);
    return models.map((model) => model.toEntity()).toList();
  }
}
