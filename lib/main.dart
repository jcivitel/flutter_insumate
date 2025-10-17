import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_insumate/themes/dark_theme.dart';
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
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
