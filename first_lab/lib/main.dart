import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<IconData> icons = [ //определяем какие иконки могут быть
    Icons.access_alarm,
    Icons.accessibility_new,
    Icons.ac_unit,
    Icons.account_circle,
    Icons.ad_units,
    Icons.airplanemode_active,
    Icons.all_inbox,
    Icons.android,
    Icons.apartment,
    Icons.archive,
  ];

  ///Выбираем рандомно иконку
  IconData getRandomIcon() {
    final random = Random();
    return icons[random.nextInt(icons.length)];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Бусыгина Татьяна'),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (_) => Icon(getRandomIcon())),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (_) => Icon(getRandomIcon())),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (_) => Icon(getRandomIcon())),
            ),
          ],
        ),
      ),
    );
  }
}
