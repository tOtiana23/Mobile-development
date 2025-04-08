import 'package:first_lab/cubit/credit_cubut.dart';
import 'package:first_lab/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreditCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Бусыгина Татьяна. Калькулятор простых процентов',
        home: MainScreen(),
      ),
    );
  }
}


