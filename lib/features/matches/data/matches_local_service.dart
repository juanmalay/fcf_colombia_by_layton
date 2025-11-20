import 'dart:convert';
import 'package:flutter/services.dart';

class MatchesLocalService {
  static Future<Map<String, dynamic>> loadMatches() async {
    final jsonString = await rootBundle.loadString('assets/data/matches.json');
    return jsonDecode(jsonString);
  }
}
