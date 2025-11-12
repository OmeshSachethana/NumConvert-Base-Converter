import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistoryStorage {
  static const _key = 'conversion_history';

  static Future<void> addHistory(String input, String output) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();
    final newItem = {
      'input': input,
      'output': output,
      'time': DateTime.now().toString(),
    };
    history.insert(0, newItem);
    await prefs.setString(_key, jsonEncode(history));
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(jsonString));
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
