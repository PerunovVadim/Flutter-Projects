import 'package:final_application/cubit/weather_cubit.dart';
import 'package:final_application/screens/main_screen.dart';
import 'package:final_application/weatherAPI/open_weather_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MainScreenProvider extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherCubit>(
      create: (context) => WeatherCubit(weatherAPI: OpenWeatherAPI()),
      child: WeatherScreen());
  }
}