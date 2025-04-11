import 'package:credit/cubit/credit_cubit/credit_cubut.dart';
import 'package:credit/cubit/history_cubit/history_cubit.dart';
import 'package:credit/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Создаем MultiBlocProvider для управления несколькими BLoC
    return MultiBlocProvider(
      providers: [
        // Предоставляем CreditCubit для управления состоянием кредита
        BlocProvider(create: (context) => CreditCubit()),
        // Предоставляем HistoryCubit для управления историей операций
        BlocProvider(create: (context) => HistoryCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Бусыгина Татьяна. Калькулятор простых процентов',
        home: MainScreen(),
      ),
    );
  }
}
