import 'package:first_lab/screens/second_screen.dart';
import 'package:flutter/material.dart';

import 'screens/first_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Бусыгина Татьяна. Калькулятор простых процентов',
      home: FirstScreen(),
      routes: {
        '/second' : (context) => const SecondScreen(),
      }
    );
  }
}


