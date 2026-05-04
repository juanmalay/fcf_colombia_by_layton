import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/team_model.dart';
import 'teams_local_datasource.dart';

/// Local datasource de equipos con caché en memoria y semilla desde assets.
class TeamsLocalDataSourceImpl implements TeamsLocalDataSource {
  static const String _assetPath = 'assets/data/teams.json';

  List<TeamModel>? _cache;

  @override
  Future<void> saveTeams(List<TeamModel> teams) async {
    _cache = teams;
  }

  @override
  Future<List<TeamModel>> getTeams() async {
    if (_cache != null) {
      return _cache!;
    }

    final jsonString = await rootBundle.loadString(_assetPath);
    final map = jsonDecode(jsonString) as Map<String, dynamic>;
    final list = (map['teams'] as List<dynamic>? ?? [])
        .map((item) => TeamModel.fromJson(item as Map<String, dynamic>))
        .toList();

    _cache = list;
    return list;
  }

  @override
  Future<TeamModel?> getTeamById(String id) async {
    final teams = await getTeams();
    for (final team in teams) {
      if (team.id == id) {
        return team;
      }
    }
    return null;
  }

  @override
  Future<TeamModel?> getTeamByName(String name) async {
    final teams = await getTeams();
    final normalized = name.toLowerCase();
    for (final team in teams) {
      if (team.name.toLowerCase() == normalized) {
        return team;
      }
    }
    return null;
  }
}
