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
    
    // Keep only the last 50 items to prevent storage issues
    if (history.length > 50) {
      history.removeRange(50, history.length);
    }
    
    await prefs.setString(_key, jsonEncode(history));
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    
    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((item) => Map<String, dynamic>.from(item)).toList();
    } catch (e) {
      // If there's an error parsing, clear the corrupted data
      await clearHistory();
      return [];
    }
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  // Add this method to remove individual history items
  static Future<void> removeHistoryItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();
    
    if (index >= 0 && index < history.length) {
      history.removeAt(index);
      await prefs.setString(_key, jsonEncode(history));
    }
  }

  // Optional: Method to format the time for display
  static String formatTime(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} - ${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return dateTimeString;
    }
  }
}