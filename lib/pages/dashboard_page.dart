import 'package:flutter/material.dart';
import 'package:flutter_insumate/login/login_page.dart';
import 'package:flutter_insumate/pages/user_profile.dart';
import 'package:flutter_insumate/pages/widgets/meal_history.dart';
import 'package:flutter_insumate/pages/widgets/recent_search.dart';
import 'package:flutter_insumate/tools/api_key_manager.dart';
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
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              ApiKeyManager.clearApiKey();
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(child: RecentSearch()),
            SizedBox(height: 10),
            Card(child: MealHistory()),
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
