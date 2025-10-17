import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_insumate/tools/api_service.dart';

class MealHistory extends StatefulWidget {
  const MealHistory({super.key});

  @override
  State<StatefulWidget> createState() => _MealHistoryState();
}

class _MealHistoryState extends State<MealHistory> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _mealHistory = [];

  @override
  void initState() {
    super.initState();
    _loadMealHistory();
  }

  Future<void> _loadMealHistory() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await ApiService.getMealHistory();
      if (response != null) {
        setState(() {
          _mealHistory = List<Map<String, dynamic>>.from(response);
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading meal history: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.history, size: 30),
              const SizedBox(width: 5),
              const Text(
                'Your Meal History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(),
          _isLoading
              ? const Center(
                child: Column(
                  children: [
                    Text(
                      'Loading recent history...',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    CircularProgressIndicator(),
                  ],
                ),
              )
              : _mealHistory.isEmpty
              ? const Text(
                'No meal history available.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              )
              : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _mealHistory.length,
                itemBuilder: (context, index) {
                  final meal = _mealHistory[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.restaurant),
                      title: Text(
                        meal['name'] ?? 'Unknown',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('KE: ${meal['KE'] ?? 'N/A'}'),
                          Text(
                            'Barcode: ${meal['barcode'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            _formatTimestamp(meal['timestamp']),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }

  String _formatTimestamp(String? timestamp) {
    if (timestamp == null) return 'Unknown time';
    try {
      final dateTime = DateTime.parse(timestamp);
      return '${dateTime.day}.${dateTime.month}.${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return timestamp;
    }
  }
}
