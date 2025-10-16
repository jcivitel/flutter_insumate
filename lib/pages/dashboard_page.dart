import 'package:flutter/material.dart';
import 'package:flutter_insumate/pages/user_profile.dart';
import 'package:flutter_insumate/tools/api_service.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => UserProfileCard()),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          children: [
            Card(
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Your recent searches'),
                        SizedBox(width: 10),
                        Icon(Icons.search),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No recent searches'),
                        SizedBox(width: 10),
                        Icon(Icons.history),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_rounded),
        onPressed: () {
          debugPrint('Floating Action Button Pressed');
        },
      ),
    );
  }
}
