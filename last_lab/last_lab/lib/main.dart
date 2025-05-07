import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_lab/cubit/weather_cubit.dart';
import 'package:last_lab/screen/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Погода',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const WeatherScreen(),
      ),
    );
  }
}