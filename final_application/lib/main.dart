import 'package:final_application/cubit/weather_provider.dart';
import 'package:final_application/screens/calculation_screen.dart';
import 'package:final_application/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Погода',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MainScreenProvider(),
    );
  }
}

