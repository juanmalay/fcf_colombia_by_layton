import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/kit_model.dart';
import 'kits_local_datasource.dart';

class KitsLocalDataSourceImpl implements KitsLocalDataSource {
  static const String _assetPath = 'assets/data/kits.json';

  List<KitModel>? _cache;

  @override
  Future<List<KitModel>> getKits() async {
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
  Future<List<KitModel>> getKitsByTeamId(String teamId) async {
    final kits = await getKits();
    return kits.where((kit) => kit.teamId == teamId).toList();
  }

  @override
  Future<KitModel?> getKitById(String id) async {
    final kits = await getKits();
    for (final kit in kits) {
      if (kit.id == id) {
        return kit;
      }
    }
    return null;
  }
}
