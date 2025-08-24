import 'package:flutter/material.dart';
import 'package:turf_together/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const SportsHomeScreen());
  }
}
