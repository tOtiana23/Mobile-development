import 'package:credit/cubit/credit_cubit/credit_cubut.dart';
import 'package:credit/cubit/credit_cubit/credit_state.dart';
import 'package:credit/screens/history_screen.dart';
import 'package:credit/widgets/input_screen.dart';
import 'package:credit/widgets/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Главный экран приложения, управляющий навигацией между состояниями
/// Использует BlocBuilder для реагирования на изменения состояния
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocBuilder слушает изменения состояния CreditCubit
    return BlocBuilder<CreditCubit, CreditState>(
      builder: (context, state) {
        // По умолчанию показываем экран ввода
        if (state is CreditInitial) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Введите данные'),
              actions: [
                // Кнопка перехода к истории расчетов
                IconButton(
                  icon: Icon(Icons.info_outline_rounded),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistoryScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: InputScreen(),
          );
        }
        // Состояние после успешного расчета - показываем результат
        else if (state is CreditCalculated) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Результат расчета'),
              // Кнопка возврата к форме ввода
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  // Сброс состояния, показ экрана с вводом данных
                  context.read<CreditCubit>().reset();
                },
              ),
              // Кнопка перехода к истории
              actions: [
                IconButton(
                  icon: Icon(Icons.info_outline_rounded),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HistoryScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            // Передаем данные расчета в виджет результата
            body: ResultScreen(
              capital: state.capital,
              period: state.period,
              rate: state.rate,
              result: state.result,
            ),
          );
        }
        // Состояние ошибки - показываем сообщение об ошибке
        else if (state is CreditError) {
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
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
