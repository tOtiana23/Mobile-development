import 'package:first_lab/cubit/credit_cubut.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultScreen extends StatelessWidget {
  final double capital;
  final double period;
  final double rate;
  final double result;

  const ResultScreen({
    super.key,
    required this.capital,
    required this.period,
    required this.rate,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = const TextStyle(fontSize: 18);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Исходный капитал: $capital руб.', style: textStyle),
          Text('Срок: $period лет', style: textStyle),
          Text('Ставка: $rate %', style: textStyle),
          const SizedBox(height: 20),
          Text(
            'Итоговая сумма: ${result.toStringAsFixed(2)} руб.',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              context.read<CreditCubit>().reset();
            },
            child: const Text('Назад'),
          ),
        ],
      ),
    );
  }
}
