import 'package:concepta_test/app_config.dart';
import 'package:concepta_test/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppConfig.colorContrast,
        body: const HomePage(),
      ),
    );
  }
}
