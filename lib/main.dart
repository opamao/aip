import 'package:aip/pages/splash/splash_screen.dart';
import 'package:aip/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agence Ivoirienne de Presse',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: oranges),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}