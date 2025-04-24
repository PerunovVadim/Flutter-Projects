import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:user_interaction_cubit/cubit/main_screen_cubit.dart";
import "package:user_interaction_cubit/cubit/main_screen_state.dart";
import 'package:user_interaction_cubit/cubit_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{
  final _formKey = GlobalKey<FormState>();
  bool _agreement = false;
  final TextEditingController _massController = TextEditingController();
  final TextEditingController _radiusController = TextEditingController();

  Widget _buildForm(){
    return Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[ 
              const Text('Масса небесного тела (кг): ', style: TextStyle(fontSize: 20.0)),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: _massController,
                textAlign: TextAlign.center,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                  return 'Введите массу';
                }
                if (double.tryParse(text) == null) {
                  return 'Введите число';
                }
                if (double.parse(text) < 0){
                    return 'Масса должна быть неотрицательной';
                  }
                }
              ),
              const Text('Радиус небесного тела (м): ', style: TextStyle(fontSize: 20.0)),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                controller: _radiusController,
                textAlign: TextAlign.center,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                  return 'Введите радиус';
                  }
                  if (double.tryParse(text) == null) {
                    return 'Введите число';
                  }

                  if (double.parse(text) <= 0){
                    return 'Радиус должен быть больше нуля';
                  }
                }
              ),
              CheckboxListTile(
                value: _agreement,
                title: Text("Я согласен на обработку персональных данных"),
                onChanged: (bool? value) => setState(()=>_agreement = value!),
              ),
              ElevatedButton(onPressed: () {
                  if (_formKey.currentState!.validate() && _agreement) {
                    final mass = double.parse(_massController.text);
                    final radius = double.parse(_radiusController.text);
                    context.read<MainScreenCubit>().calculateFirstCosmicVelocity(mass, radius);
                  }
              }, 
              child: const Text('Рассчитать', style: TextStyle(fontSize: 14.0)))
            ],)
        ,)
    );
  }

  Widget _buildResult(double velocity){
    return Container(
      child : Column(
        children: <Widget> [
          Text('Первая космическая скорость равна: ${velocity.toStringAsPrecision(3)} м/с', 
                style: TextStyle(fontSize: 14.0)),
          ElevatedButton(onPressed: () {context.read<MainScreenCubit>().reset();},
          child: const Text('Вернуться', style: TextStyle(fontSize: 14.0)))
        ]
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Перунов Вадим Дмитриевич ИВТ-22')),
      body: BlocBuilder<MainScreenCubit, MainScreenState>(
        builder: (context, state) {
          if (state is MainScreenStateCalculate) {
            return _buildResult(state.velocity);
          } else {
            return _buildForm();
          }
        },
      ),
    );
  }
}