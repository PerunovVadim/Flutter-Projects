// weather_screen.dart
import 'package:final_application/cubit/weather_cubit.dart';
import 'package:final_application/cubit/weather_states.dart';
import 'package:final_application/models/weather_data.dart';
import 'package:final_application/screens/about_screen.dart';
import 'package:final_application/screens/calculation_screen.dart';
import 'package:final_application/screens/camera_screen.dart';
import 'package:final_application/screens/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherScreen extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Погода по городу'),
        actions: [
    IconButton(
      icon: const Icon(Icons.calculate),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DewPointCalculator(),
          ),
        );
      },
      tooltip: 'Калькулятор точки росы',
    ),IconButton(
      icon: const Icon(Icons.info),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AboutScreen(),
          ),
        );
      },
      tooltip: 'О разработчике',
    ),
    IconButton(
      icon: const Icon(Icons.history),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HistoryScreen()),
        );
      },
      tooltip: 'История запросов',
    ),
    IconButton(
      icon: const Icon(Icons.camera),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CameraScreen()),
        );
      },
      tooltip: 'Сфотографировать термометр',
    )
  ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'Введите город',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _fetchWeather(context),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _fetchWeather(context),
                  child: const Text('Поиск'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WeatherError) {
                  return Text(
                    state.message,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  );
                } else if (state is WeatherLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.weatherData.list?.length ?? 0,
                      itemBuilder: (context, index) {
                        final cityWeather = state.weatherData.list![index];
                        return _buildWeatherCard(cityWeather);
                      },
                    ),
                  );
                } else {
                  return const Text(
                    'Введите город для поиска',
                    style: TextStyle(fontSize: 16),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _fetchWeather(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.read<WeatherCubit>().fetchWeather(_cityController.text);
  }

  Widget _buildWeatherCard(WeatherData cityWeather) {
    final weather = cityWeather.weather?.first;
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${cityWeather.name}, ${cityWeather.sys?.country}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${cityWeather.main?.temp?.toStringAsFixed(1)}°C',
                      style: const TextStyle(fontSize: 32),
                    ),
                    Text(
                      'Ощущается как ${cityWeather.main?.feelsLike?.toStringAsFixed(1)}°C',
                      style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 228, 225, 225)),
                    ),
                  ],
                ),
                if (weather != null)
                  Column(
                    children: [
                      Image.network(
                        'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                        width: 60,
                        height: 60,
                      ),
                      Text(
                        weather.description ?? '',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildWeatherDetail('Влажность', '${cityWeather.main?.humidity}%'),
                _buildWeatherDetail('Давление', '${cityWeather.main?.pressure} hPa'),
                _buildWeatherDetail('Ветер', '${cityWeather.wind?.speed} м/с'),
                _buildWeatherDetail('Облачность', '${cityWeather.clouds?.all}%'),
              ],
            ),
          ],
        ),
      ),);
  }

  Widget _buildWeatherDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Color.fromARGB(255, 218, 214, 214)),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}