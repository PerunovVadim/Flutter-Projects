import 'dart:math';
import 'package:data_store/cubit/main_screen_state.dart';
import 'package:data_store/database/database_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenStateInput());

  void calculateFirstCosmicVelocity(double mass, double radius) {
    const gravitationalConstant = 6.67430e-11; 
    var velocity = sqrt((gravitationalConstant * mass) / radius);
    insertIntoHistory(mass, radius,velocity);
    emit(MainScreenStateCalculate(velocity: velocity));

    
  }

  void insertIntoHistory(double mass,double radius,double result){
    DatabaseProvider.db.addRecord({'mass':mass,'radius' : radius,'result' : result});
    print("добавлено"); // ← Это можно увидеть в логах
  }

  void reset() {
    emit(MainScreenStateInput());
  }
}

