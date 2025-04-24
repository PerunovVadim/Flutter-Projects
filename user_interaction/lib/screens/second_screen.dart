import 'dart:math';

import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key, required this.title, required this.mass, required this.radius});

  final String title;
  final double mass;
  final double radius;
  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  double _calculateFirstCosmicVelocity(double mass, double radius) {
    const gravitationalConstant = 6.67430e-11; // Гравитационная постоянная
    return sqrt((gravitationalConstant * mass) / radius);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: Text("Перунов Вадим Дмитриевич ИВТ-22"), // Используем title из widget
        centerTitle: true, // Опционально: центрировать заголовок
      ),
      body: Container(
      child : Column(
        children: <Widget> [
          Text('Первая космическая скорость равна : ${_calculateFirstCosmicVelocity(widget.mass, widget.radius).toStringAsPrecision(3)} м/с', 
                style: TextStyle(fontSize: 14.0)),
          ElevatedButton(onPressed: () {Navigator.pop(context);},
          child: const Text('Вернуться', style: TextStyle(fontSize: 14.0)))
        ]
      )
    ));

    
  }
}