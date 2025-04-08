import 'package:first_lab/cubit/credit_cubut.dart';
import 'package:first_lab/cubit/credit_state.dart';
import 'package:first_lab/widgets/input_screen.dart';
import 'package:first_lab/widgets/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCubit, CreditState>(
      builder: (context, state) {
        if (state is CreditInitial) {
          return Scaffold(
            appBar: AppBar(title: Text('Введите данные')),
            body: InputScreen(),
          );
        } else if (state is CreditCalculated) {
          return Scaffold(
            appBar: AppBar(title: Text('Результат расчета')),
            body: ResultScreen(
              capital: state.capital,
              period: state.period,
              rate: state.rate,
              result: state.result,
            ),
          );
        } else if (state is CreditError) {
          return Scaffold(
            appBar: AppBar(title: Text('Ошибка')),
            body: Center(
              child: Text(
                state.message,
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
