import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_lab/model/weather_model.dart';
import 'package:last_lab/requests/weather_api.dart';
import 'package:last_lab/utils/weather_history_utils.dart';
import 'weather_state.dart';

// Cubit для управления состоянием погодных данных
class WeatherCubit extends Cubit<WeatherState> {
  final WeatherApi _weatherApi;

  // Справочник городов с их locationKey для AccuWeather API
  final Map<String, String> cities = {
    'Чита': '291605',
    'Санкт-Петербург': '295212',
    'Омск': '294463',
  };

  WeatherCubit() 
    : _weatherApi = WeatherApi('294463'), // Инициализируем с дефолтным значением
      super(WeatherInitial()) {
    loadInitialWeather();
  }

  String selectedCity = 'Омск';
  List<String> _history = []; // Локальный кеш истории запросов

  // Загружает начальные данные: историю и погоду для выбранного города
  Future<void> loadInitialWeather() async {
    await _loadHistory(); // Сначала загружаем историю
    await fetchWeather(selectedCity); // Затем актуальную погоду
  }

  // Основной метод для загрузки погодных данных
  Future<void> fetchWeather(String cityName) async {
    emit(WeatherLoading()); // Устанавливаем состояние загрузки
    selectedCity = cityName; // Обновляем текущий город

    try {
      // Получаем locationKey для выбранного города
      final locationKey = cities[cityName];
      if (locationKey == null) {
        emit(const WeatherError('Город не найден'));
        return;
      }

      // Создаем новый экземпляр WeatherApi с новым ключом
      final weatherApi = WeatherApi(locationKey);
      // Параллельно запрашиваем погоду и название города
      final weather = await weatherApi.getCurrentWeather();
      final city = await weatherApi.getCityName();

      if (weather != null && city != null) {
        // Формируем запись для истории
        final entry =
            '$city: ${weather.description}, '
            'Темп: ${weather.temperature?.metric?.value?.toStringAsFixed(1)}°, '
            'Ветер: ${weather.wind?.speed?.metric?.value}';
        // Сохраняем и обновляем историю
        await WeatherHistoryUtils.saveWeatherEntry(entry);
        await _loadHistory();
        // Устанавливаем состояние с загруженными данными
        emit(WeatherLoaded(
          weather: weather,
          city: city,
          history: _history,
        ));
      } else {
        emit(const WeatherError('Не удалось загрузить погоду'));
      }
    } catch (e) {
      emit(WeatherError('Ошибка: $e'));
    }
  }

  // Загружает историю запросов из хранилища
  Future<void> _loadHistory() async {
    _history = await WeatherHistoryUtils.getHistory();
  }

  // Очищает историю запросов
  Future<void> clearHistory() async {
    await WeatherHistoryUtils.clearHistory();
    _history = [];
    
    // Если текущее состояние - загруженные данные,
    // обновляем его с пустой историей
    if (state is WeatherLoaded) {
      final currentState = state as WeatherLoaded;
      emit(WeatherLoaded(
        weather: currentState.weather,
        city: currentState.city,
        history: _history,
      ));
    }
  }
}