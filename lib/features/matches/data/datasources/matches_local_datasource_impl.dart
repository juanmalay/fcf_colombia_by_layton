import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/match_model.dart';
import 'matches_local_datasource.dart';
import '../../../../core/utils/logger.dart';

/// Local datasource backed by memory cache plus assets/data/matches.json seed data.
class MatchesLocalDataSourceImpl implements MatchesLocalDataSource {
  final Map<String, List<MatchModel>> _cache = {};

  static const String _assetPath = 'assets/data/matches.json';
  static const String _upcomingKey = 'upcoming_matches';
  static const String _recentKey = 'recent_matches';

  @override
  Future<void> saveMatches(List<MatchModel> matches, String key) async {
    try {
      AppLogger.info(
        'Saving ${matches.length} matches to local cache with key: $key',
      );
      _cache[key] = matches;
    } catch (e) {
      AppLogger.error('Error saving matches to local cache', e);
      rethrow;
    }
  }

  @override
  Future<List<MatchModel>> getMatches(String key) async {
    try {
      if (!_cache.containsKey(key)) {
        await _loadSeedData();
      }

      final matches = _cache[key] ?? [];
      AppLogger.info(
        'Retrieved ${matches.length} matches from local cache (key: $key)',
      );
      return matches;
    } catch (e) {
      AppLogger.error('Error retrieving matches from local cache', e);
      return [];
    }
  }

  @override
  Future<void> clearCache(String key) async {
    try {
      AppLogger.info('Clearing local cache with key: $key');
      _cache.remove(key);
    } catch (e) {
      AppLogger.error('Error clearing local cache', e);
      rethrow;
    }
  }

  @override
  Future<bool> hasMatches(String key) async {
    try {
      if (!_cache.containsKey(key)) {
        await _loadSeedData();
      }

      final has = _cache.containsKey(key) && (_cache[key]?.isNotEmpty ?? false);
      AppLogger.info('Checking cache (key: $key): $has');
      return has;
    } catch (e) {
      AppLogger.error('Error checking local cache', e);
      return false;
    }
  }

  Future<void> _loadSeedData() async {
    try {
      final jsonString = await rootBundle.loadString(_assetPath);
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      final nextMatches = (jsonMap['nextMatches'] as List<dynamic>? ?? [])
          .map((item) => MatchModel.fromJson(item as Map<String, dynamic>))
          .toList();
      final results = (jsonMap['results'] as List<dynamic>? ?? [])
          .map((item) => MatchModel.fromJson(item as Map<String, dynamic>))
          .toList();

      _cache.putIfAbsent(_upcomingKey, () => nextMatches);
      _cache.putIfAbsent(_recentKey, () => results);
      AppLogger.info('Loaded local seed matches from $_assetPath');
    } catch (e) {
      AppLogger.error('Error loading local seed matches', e);
    }
  }
}
