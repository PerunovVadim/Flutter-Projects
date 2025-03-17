import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Лабораторная работа'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Wrap(
            spacing: 8.0,
            children: [
            Container(
              padding: EdgeInsets.all(8.0),
              color: const Color.fromARGB(255, 224, 207, 153),
              child: Text('ФИО: Перунов Вадим Дмитриевич'),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              color: const Color.fromARGB(255, 187, 241, 173),
              child: Text('Группа: ИВТ-22'),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              color: const Color.fromARGB(255, 170, 176, 236),
              child: Text('Год рождения: 2004'),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Colors.amber,
              child: Text('Пол: Мужской'),
            ),
            ],
),

        ],
      ),
    );
  }
}