import 'package:credit/cubit/history_cubit/history_cubit.dart';
import 'package:credit/cubit/history_cubit/history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Экран для отображения истории расчетов
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Создаем и инициализируем HistoryCubit при создании экрана
    return BlocProvider(
      // При создании Cubit сразу загружаем историю расчетов
      create: (context) => HistoryCubit()..loadCalculations(),
      child: Scaffold(
        appBar: AppBar(title: const Text('История расчетов')),
        body: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            // Состояние загрузки
            if (state is HistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Состояние ошибки
            if (state is HistoryError) {
              return Center(child: Text(state.message));
            }

            // Состояние успешной загрузки, показываем список
            if (state is HistoryLoaded) {
              final calculations = state.calculations;

              // Список пуст
              if (calculations.isEmpty) {
                return const Center(child: Text('Нет сохраненных расчетов'));
              }

              // Строим список расчетов
              return ListView.builder(
                itemCount: calculations.length,
                itemBuilder: (context, index) {
                  final calc = calculations[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      // Результат расчета
                      title: Text(
                        'Результат: ${calc['result']?.toStringAsFixed(2)}',
                      ),
                      // Дополнительная информация
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Капитал: ${calc['capital']}'),
                          Text('Срок: ${calc['period']} лет'),
                          Text('Ставка: ${calc['rate']}%'),
                          Text('Дата: ${calc['timestamp']}'),
                        ],
                      ),
                      // Кнопка удаления расчета
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          // Удаляем расчет по id
                          await context.read<HistoryCubit>().deleteCalculation(
                            calc['id'],
                          );
                          // Уведомление об удалении
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Расчёт удален')),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(child: Text('Загрузка данных...'));
          },
        ),
      ),
    );
  }
}