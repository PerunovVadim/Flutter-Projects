import 'package:data_store/cubit/history_screen_cubit.dart';
import 'package:data_store/cubit/history_screen_state.dart';

import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:data_store/cubit/history_screen_cubit_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>{

  @override
  void initState() {
    super.initState();
    
    context.read<HistoryScreenCubit>().getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Перунов Вадим Дмитриевич ИВТ-22')),
      body: BlocBuilder<HistoryScreenCubit, HistoryScreenStateList>(
        builder: (context, state) {
          return _build(state.data);
          
        },
      ),
    );
  }

  Widget _build(List<Map<String,dynamic>>? data){
    if (data == null || data.isEmpty) {
    return const Center(
      child: Text('История расчетов пуста'),
    );
  }

  return ListView.builder(
    itemCount: data.length,
    itemBuilder: (context, index) {
      final record = data[index];
      return Card(
        margin: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(
            'Результат: ${record['result']?.toStringAsPrecision(3) ?? 'N/A'} м/с',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Масса: ${record['mass']} кг'),
              Text('Радиус: ${record['radius']} м'),
              Text('Дата: ${record['created_at']}'),
            ],
          ),
          
        ),
      );
    },
  );
  }
}