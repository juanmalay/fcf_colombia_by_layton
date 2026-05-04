import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _settingsPrefix = 'setting_';

class SettingsNotifier extends StateNotifier<Map<String, bool>> {
  SettingsNotifier()
      : super({
          'match_notifications': true,
          'goal_notifications': true,
          'news_notifications': false,
          'dark_theme': true,
          'sync_data': false,
        }) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = {
      for (final entry in state.entries)
        entry.key: prefs.getBool('$_settingsPrefix${entry.key}') ?? entry.value,
    };
  }

  Future<void> setValue(String key, bool value) async {
    state = {...state, key: value};
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_settingsPrefix$key', value);
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, Map<String, bool>>((ref) {
  return SettingsNotifier();
});
