import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiKeyManager {
  static const _keyApiKey = 'api_key';
  static const _keyExpiry = 'api_key_expiry';
  static const _lifetimeMinutes = 30;

  static Future<String?> getApiKey() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final apiKey = prefs.getString(_keyApiKey);
      final expiry = prefs.getInt(_keyExpiry);
      final now = DateTime
          .now()
          .millisecondsSinceEpoch;
      if (apiKey != null && expiry != null && now < expiry) {
        return apiKey;
      }
      debugPrint('Kein gültiger API-Key gefunden oder abgelaufen.');
      return null;
    } catch (e) {
      debugPrint('Fehler beim Zugriff auf SharedPreferences: $e');
      return null;
    }
  }

  static Future<void> setApiKey(String apiKey) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final expiry = DateTime
          .now()
          .add(const Duration(minutes: _lifetimeMinutes))
          .millisecondsSinceEpoch;
      await prefs.setString(_keyApiKey, apiKey);
      await prefs.setInt(_keyExpiry, expiry);
    } catch (e) {
      debugPrint('Fehler beim Speichern des API-Key: $e');
    }
  }

  static Future<void> clearApiKey() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyApiKey);
      await prefs.remove(_keyExpiry);
    } catch (e) {
      debugPrint('Fehler beim Löschen des API-Key: $e');
    }
  }
}