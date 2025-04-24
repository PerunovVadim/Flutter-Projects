import 'package:flutter/material.dart';
import 'package:user_interaction/screens/second_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final _formKey = GlobalKey<FormState>();
  bool _agreement = false;
  final TextEditingController _massController = TextEditingController();
  final TextEditingController _radiusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: Text("Перунов Вадим Дмитриевич ИВТ-22"), // Используем title из widget
        centerTitle: true, // Опционально: центрировать заголовок
      ) , body: Container(
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
                  if (_formKey.currentState!.validate() && _agreement){
                    final double mass = double.parse(_massController.text);
                    final double radius = double.parse(_radiusController.text);

                    Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen(title: "Результат",mass: mass,radius: radius)
                      ));
                  }
              }, 
              child: const Text('Рассчитать', style: TextStyle(fontSize: 14.0)))
            ],)
        ,)
    ));
  }
}