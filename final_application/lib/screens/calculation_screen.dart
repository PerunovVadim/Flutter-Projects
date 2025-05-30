import 'dart:math';

import 'package:final_application/database/database_provider.dart';
import 'package:flutter/material.dart';

class DewPointCalculator extends StatefulWidget {
  const DewPointCalculator({super.key});

  @override
  _DewPointCalculatorState createState() => _DewPointCalculatorState();
}

class _DewPointCalculatorState extends State<DewPointCalculator> {
  final _formKey = GlobalKey<FormState>();
  final _temperatureController = TextEditingController();
  final _humidityController = TextEditingController();
  double? _dewPoint;

  @override
  void dispose() {
    _temperatureController.dispose();
    _humidityController.dispose();
    super.dispose();
  }

  void _calculateDewPoint() {
    if (_formKey.currentState!.validate()) {
      final temperature = double.parse(_temperatureController.text);
      final humidity = double.parse(_humidityController.text);

      
      final a = 17.27;
      final b = 237.7;
      final alpha = ((a * temperature) / (b + temperature)) + log(humidity / 100);
      final dewPoint = (b * alpha) / (a - alpha);

       DatabaseProvider.db.addCalcRecord({
        'temperature': temperature,
        'humidity': humidity,
        'result': dewPoint,
      });

      setState(() {
        _dewPoint = dewPoint;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор точки росы'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _temperatureController,
                decoration: const InputDecoration(
                  labelText: 'Температура (°C)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите температуру';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите корректное число';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _humidityController,
                decoration: const InputDecoration(
                  labelText: 'Относительная влажность (%)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите влажность';
                  }
                  final humidity = double.tryParse(value);
                  if (humidity == null) {
                    return 'Введите корректное число';
                  }
                  if (humidity < 0 || humidity > 100) {
                    return 'Влажность должна быть от 0 до 100%';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calculateDewPoint,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text('Рассчитать точку росы'),
              ),
              const SizedBox(height: 24),
              if (_dewPoint != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Точка росы:',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          '${_dewPoint!.toStringAsFixed(1)} °C',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
