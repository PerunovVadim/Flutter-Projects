import 'dart:math';
import 'package:user_interaction_cubit/cubit/main_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenStateInput());

  void calculateFirstCosmicVelocity(double mass, double radius) {
    const gravitationalConstant = 6.67430e-11; 
    var velocity = sqrt((gravitationalConstant * mass) / radius);
    emit(MainScreenStateCalculate(velocity: velocity));
  }

  void reset() {
    emit(MainScreenStateInput());
  }
}

