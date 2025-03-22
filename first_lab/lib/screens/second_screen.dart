import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  double calculateSimpleInterest(double capital, double period, double rate) {
    return capital + (capital * period * rate / 100);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = const TextStyle(fontSize: 18);
    // Получение данных с первого экрана
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, double>;
    final capital = args['capital']!;
    final period = args['period']!;
    final rate = args['rate']!;

    // Расчет результата
    final result = calculateSimpleInterest(capital, period, rate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Результат'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Исходный капитал: $capital руб.', style: textStyle),
            Text('Срок начисления: $period лет', style: textStyle),
            Text('Ставка процентов: $rate %', style: textStyle),
            const SizedBox(height: 20),
            Text(
              'Итоговая сумма: ${result.toStringAsFixed(2)} руб.',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
