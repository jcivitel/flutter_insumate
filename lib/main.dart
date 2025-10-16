import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_insumate/tools/api_key_manager.dart';

import 'login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint("Lade .env Datei");
  dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insumate',
      theme: ThemeData(primarySwatch: Colors.green),
      darkTheme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
        primaryColor: Colors.green[700],
        scaffoldBackgroundColor: Colors.grey[600],
        cardTheme: CardTheme(
          color: Colors.grey[800],
          shadowColor: Colors.black,
          elevation: 5,
          margin: const EdgeInsets.all(10),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.green[700],
          actionsIconTheme: IconThemeData(color: Colors.grey[200]),
          iconTheme: IconThemeData(color: Colors.grey[200]),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green[700],
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
