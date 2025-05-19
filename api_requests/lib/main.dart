import 'package:flutter/material.dart';
import 'package:api_requests/cubit/nasa_cubit_provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Перунов Вадим ИВТ-22',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainScreenProvider(),
    );
  }
}