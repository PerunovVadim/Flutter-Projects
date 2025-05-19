import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_store/cubit/history_screen_cubit.dart';
import 'package:data_store/screens/history_screen.dart';

class HistoryScreenProvider extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider<HistoryScreenCubit>(
      create: (context) => HistoryScreenCubit(),
      child: HistoryScreen());
  }
}