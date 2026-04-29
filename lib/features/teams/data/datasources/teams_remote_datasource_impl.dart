import '../../../../core/services/dio_service.dart';
import '../../../../core/network/endpoints.dart';
import '../models/team_model.dart';
import '../../domain/entities/team.dart';
import 'teams_remote_datasource.dart';

/// Implementación de TeamsRemoteDataSource
class TeamsRemoteDataSourceImpl implements TeamsRemoteDataSource {
  final DioService dio;

  const TeamsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Team>> getAllTeams() async {
    try {
      final response = await dio.get(ApiEndpoints.allTeams);
      final List<dynamic> data = response.data as List<dynamic>;
      return data.map((json) => TeamModel.fromJson(json as Map<String, dynamic>).toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Team?> getTeamDetail(String id) async {
    try {
      final response = await dio.get(ApiEndpoints.getTeamDetail(id));
      final model = TeamModel.fromJson(response.data as Map<String, dynamic>);
      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Team?> getTeamByName(String name) async {
    try {
      final response = await dio.get(ApiEndpoints.getTeamByName(name));
      final model = TeamModel.fromJson(response.data as Map<String, dynamic>);
      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
