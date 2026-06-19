import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: WashNRollApp()));
}

class WashNRollApp extends StatelessWidget {
  const WashNRollApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wash N Roll',
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A1A2E)),
      ),
      home: const SplashScreen(),
    );
  }
}
