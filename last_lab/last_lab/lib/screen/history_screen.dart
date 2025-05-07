import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_lab/cubit/weather_cubit.dart';
import 'package:last_lab/cubit/weather_state.dart';

// Экран истории погодных запросов, отображает список ранее сделанных запросов погоды
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История погоды'),
        actions: [
          // Кнопка очистки истории
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              // Вызываем метод очистки истории из Cubit
              await context.read<WeatherCubit>().clearHistory();
              // Показываем уведомление об успешной очистке
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('История очищена')),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          // Обработка состояния загрузки данных
          if (state is WeatherLoaded) {
            final history = state.history;
            // Проверка на пустую историю
            if (history.isEmpty) {
              return const Center(child: Text('История пуста'));
            }
            // Отображение списка истории
            return ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(history[index]));
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}