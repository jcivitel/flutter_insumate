import 'package:flutter/material.dart';

class RecentSearch extends StatefulWidget {
  const RecentSearch({super.key});

  @override
  State<StatefulWidget> createState() => _RecentSearchState();
}

class _RecentSearchState extends State<RecentSearch> {
  bool _isLoading = true;


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
              : Text(
                'This is a placeholder for recent search functionality.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
        ],
      ),
    );
  }
}
