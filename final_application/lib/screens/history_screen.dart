import 'package:final_application/database/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  
  List<Map<String, dynamic>> _combinedHistory = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final weatherHistory = await DatabaseProvider.db.getWeatherHistory();
    final calcHistory = await  DatabaseProvider.db.getCalcHistory();

    final combined = [
      ...weatherHistory.map((e) => {...e, 'type': 'weather'}),
      ...calcHistory.map((e) => {...e, 'type': 'calc'})
    ];

    // Сортируем по дате (новые сверху)
    combined.sort((a, b) => b['created_at'].compareTo(a['created_at']));

    setState(() {
      _combinedHistory = combined;
    });
  }

  String _formatDateTime(String dateTime) {
    final formatter = DateFormat('dd.MM.yyyy HH:mm');
    return formatter.format(DateTime.parse(dateTime));
  }

  Widget _buildHistoryItem(Map<String, dynamic> item) {
    final isWeather = item['type'] == 'weather';
    final date = _formatDateTime(item['created_at']);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: isWeather
            ? Image.network(
                'https://openweathermap.org/img/wn/${item['icon_code']}.png',
                width: 40,
              )
            : const Icon(Icons.calculate, size: 40),
        title: Text(
          isWeather
              ? '${item['city_name']} (${item['country_code']})'
              : 'Расчет точки росы',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isWeather
                ? '${item['temperature']?.toStringAsFixed(1)}°C, ${item['weather_description']}'
                : 'Температура: ${item['temperature']}°C, Влажность: ${item['humidity']}%'),
            Text(date, style: const TextStyle(color: Colors.grey)),
          ],
        ),
        trailing: isWeather
            ? Text('${item['humidity']}%')
            : Text('${item['result']?.toStringAsFixed(1)}°C'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История запросов'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadHistory,
            tooltip: 'Обновить',
          ),
        ],
      ),
      body: _combinedHistory.isEmpty
          ? const Center(child: Text('История пуста'))
          : ListView.builder(
              itemCount: _combinedHistory.length,
              itemBuilder: (context, index) {
                return _buildHistoryItem(_combinedHistory[index]);
              },
            ),
    );
  }
}