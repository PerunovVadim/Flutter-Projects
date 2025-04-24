import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_interaction_cubit/cubit/main_screen_cubit.dart';
import 'package:user_interaction_cubit/main_screen.dart';

class MainScreenProvider extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainScreenCubit>(
      create: (context) => MainScreenCubit(),
      child: MainScreen());
  }
}