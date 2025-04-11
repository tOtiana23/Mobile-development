import 'package:flutter/material.dart';

/// Виджет для вывода результатов расчета
class ResultScreen extends StatelessWidget {
  final double capital; // Начальный капитал
  final double period; // Срок инвестирования в годах
  final double rate; // Процентная ставка
  final double result; // Итоговый результат расчета

  const ResultScreen({
    super.key,
    required this.capital,
    required this.period,
    required this.rate,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Отображение исходного капитала
          Text(
            'Исходный капитал: $capital',
            style: const TextStyle(fontSize: 18),
          ),

          // Отображение срока инвестирования
          Text('Срок (лет): $period', style: const TextStyle(fontSize: 18)),

          // Отображение процентной ставки
          Text('Ставка (%): $rate', style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 20),

          // Отображение итогового результата с округлением до 2 знаков после запятой
          Text(
            'Итоговый результат: ${result.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
