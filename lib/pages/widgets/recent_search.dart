import 'package:flutter/material.dart';
import 'package:flutter_insumate/tools/api_service.dart';

class RecentSearch extends StatefulWidget {
  const RecentSearch({super.key});

  @override
  State<StatefulWidget> createState() => _RecentSearchState();
}

class _RecentSearchState extends State<RecentSearch> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _recentSearch = [];

  @override
  void initState() {
    super.initState();
    _loadRecentSearch();
  }

  Future<void> _loadRecentSearch() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await ApiService.getRecentSearch();
      if (response != null) {
        setState(() {
          _recentSearch = List<Map<String, dynamic>>.from(response);
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
              Icon(Icons.zoom_in, size: 30),
              SizedBox(width: 5),
              Text(
                'Your Recent Searches',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Divider(),
          _isLoading
              ? Center(
                child: Column(
                  children: [
                    Text(
                      'Loading recent searches...',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 10),
                    CircularProgressIndicator(),
                  ],
                ),
              )
              : _recentSearch.isEmpty
              ? const Text(
                'No meal history available.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              )
              : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _recentSearch.length,
                itemBuilder: (context, index) {
                  final search = _recentSearch[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.restaurant),
                      title: Text(
                        search['name'] ?? 'Unknown',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Barcode: ${search['barcode'] ?? 'N/A'}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          Text(
                            _formatTimestamp(search['timestamp']),
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
