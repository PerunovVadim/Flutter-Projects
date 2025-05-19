import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:api_requests/cubit/nasa_cubit.dart';
import 'package:api_requests/screens/main_screen.dart';

class MainScreenProvider extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NasaCubit>(
      create: (context) => NasaCubit(),
      child: MainScreen());
  }
}