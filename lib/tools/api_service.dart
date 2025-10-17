import 'package:flutter/material.dart';
import 'package:flutter_insumate/tools/api_key_manager.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class ApiService {
  static String get baseUrl =>
      dotenv.env['API_URL'] ?? 'http://localhost:8000/api/';

  //Login Methode
  static Future<String?> login({
    required String username,
    required String password,
  }) async {
    final urlString = '${baseUrl}login/';
    final url = Uri.parse(urlString);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['api_key'] != null) {
        return data['api_key'];
      }
      return null;
    } else {
      throw Exception(
        'Login incorrect: ${response.statusCode} ${response.body}',
      );
    }
  }

  //Get User Info Methode
  static Future<List<dynamic>> getUserInfo() async {
    final apiKey = await ApiKeyManager.getApiKey();
    final urlString = '${baseUrl}v1/userinfo';
    final url = Uri.parse(urlString);
    final response = await http
        .get(url, headers: {'Authorization': 'Token $apiKey'})
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
        'error while getting information: ${response.statusCode} ${response.body}',
      );
    }
  }

  static getMealHistory() async {
    final apiKey = await ApiKeyManager.getApiKey();
    final urlString = '${baseUrl}v1/meal-entries/';
    final url = Uri.parse(urlString);
    final response = await http
        .get(url, headers: {'Authorization': 'Token $apiKey'})
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
        'error while getting information: ${response.statusCode} ${response.body}',
      );
    }
  }

  static getRecentSearch() async {
    final apiKey = await ApiKeyManager.getApiKey();
    final urlString = '${baseUrl}v1/recent-searches/';
    final url = Uri.parse(urlString);
    final response = await http
        .get(url, headers: {'Authorization': 'Token $apiKey'})
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception(
        'error while getting information: ${response.statusCode} ${response.body}',
      );
    }
  }
}
