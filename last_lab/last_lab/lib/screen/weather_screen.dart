import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_lab/screen/calculate_screen.dart';
import 'package:last_lab/screen/history_screen.dart';
import 'package:last_lab/screen/info_screen.dart';
import 'package:last_lab/utils/url_launcher_utils.dart';
import 'package:last_lab/cubit/weather_cubit.dart';
import 'package:last_lab/cubit/weather_state.dart';


// Экран отображения текущей погоды, содержит:
// Текущие погодные данные
// Навигацию к другим экранам
// Управление выбором города
class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Обеспечиваем доступ к WeatherCubit для всего поддерева виджетов
    return BlocProvider(
      create: (context) => WeatherCubit(), // Создаем экземпляр WeatherCubit
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Погода сейчас'),
          actions: [
            // Кнопка перехода на экран информации о студенте
            IconButton(
              icon: const Icon(Icons.info_outline_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InfoScreen()),
                );
              },
            ),
            // Кнопка перехода на экран калькулятора скорости ветра
            IconButton(
              icon: const Icon(Icons.calculate_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CalculateScreen()),
                );
              },
            ),
            // Кнопка открытия карты ветров в браузере
            IconButton(
              icon: const Icon(Icons.wind_power), 
              onPressed: openWindMap,
            ),
            // Кнопка перехода на экран истории запросов
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryScreen()),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            // Обработка различных состояний погоды
            if (state is WeatherInitial || state is WeatherLoading) {
              // Показываем индикатор загрузки при начальном состоянии или загрузке
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeatherError) {
              // Показываем сообщение об ошибке
              return Center(child: Text(state.message));
            } else if (state is WeatherLoaded) {
              // Показываем карточку с погодными данными
              return _buildWeatherCard(context, state);
            }
            // Запасной вариант на случай неизвестного состояния
            return const Center(child: Text('Неизвестное состояние'));
          },
        ),
      ),
    );
  }
  // Строит карточку с отображением погодных данных
  Widget _buildWeatherCard(BuildContext context, WeatherLoaded state) {
    // Получаем доступ к WeatherCubit для управления состоянием
    final cubit = context.read<WeatherCubit>();
    
    return Center(
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Выпадающий список для выбора города
              DropdownButton<String>(
                value: cubit.selectedCity,
                items: cubit.cities.keys.map((city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (value) {
                  // При изменении города запрашиваем новые погодные данные
                  if (value != null) {
                    cubit.fetchWeather(value);
                  }
                },
              ),
              const SizedBox(height: 16),
              if (state.weather.iconUrl != null)
                Image.network(
                  state.weather.iconUrl!,
                  width: 170,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 16),
              // Отображение основных погодных данных
              Text(
                '${state.city}: ${state.weather.description}\n'
                'Температура: ${state.weather.temperature?.metric?.value?.toStringAsFixed(1)}°'
                '${state.weather.temperature?.metric?.unit}\n'
                'Ветер: ${state.weather.wind?.speed?.metric?.value} ${state.weather.wind?.speed?.metric?.unit}',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}