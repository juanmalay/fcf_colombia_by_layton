import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/kits_local_datasource.dart';
import '../../data/datasources/kits_local_datasource_impl.dart';
import '../../data/repositories/kit_repository_impl.dart';
import '../../domain/entities/kit.dart';
import '../../domain/repositories/kit_repository.dart';
import '../../domain/usecases/get_team_kits_usecase.dart';

final kitsLocalDataSourceProvider = Provider<KitsLocalDataSource>((ref) {
  return KitsLocalDataSourceImpl();
});

final kitRepositoryProvider = Provider<KitRepository>((ref) {
  return KitRepositoryImpl(
    localDataSource: ref.watch(kitsLocalDataSourceProvider),
  );
});

final getTeamKitsUseCaseProvider = Provider<GetTeamKitsUseCase>((ref) {
  return GetTeamKitsUseCase(ref.watch(kitRepositoryProvider));
});

final teamKitsProvider = FutureProvider.family<List<Kit>, String>((
  ref,
  teamId,
) async {
  final useCase = ref.watch(getTeamKitsUseCaseProvider);
  return useCase(teamId);
});
