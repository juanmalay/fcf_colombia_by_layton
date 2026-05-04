import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/kit_model.dart';
import 'kits_local_datasource.dart';

class KitsLocalDataSourceImpl implements KitsLocalDataSource {
  static const String _assetPath = 'assets/data/kits.json';

  List<KitModel>? _cache;

  @override
  Future<List<KitModel>> getAllKits() async {
    if (_cache != null) {
      return _cache!;
    }

    final jsonString = await rootBundle.loadString(_assetPath);
    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    final kits = (jsonMap['kits'] as List<dynamic>? ?? [])
        .map((item) => KitModel.fromJson(item as Map<String, dynamic>))
        .toList();

    _cache = kits;
    return kits;
  }

  @override
  Future<List<KitModel>> getTeamKits(String teamId) async {
    final kits = await getAllKits();
    return kits.where((kit) => kit.teamId == teamId).toList();
  }
}
