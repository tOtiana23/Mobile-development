import 'package:equatable/equatable.dart';
import 'package:last_lab/model/weather_model.dart';

// Базовое абстрактное состояние для погодных данных
// Наследуется от Equatable для упрощения сравнения состояний
abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => []; // Список свойств для сравнения состояний
}

// Начальное состояние - приложение только запущено
// Данные еще не загружались
class WeatherInitial extends WeatherState {}

// Состояние загрузки данных
// Показывается когда идет запрос к API
class WeatherLoading extends WeatherState {}

// Состояние успешной загрузки данных
class WeatherLoaded extends WeatherState {
  final WeatherModel weather; // Модель погодных данных
  final String city; // Название города
  final List<String> history; // История предыдущих запросов

  const WeatherLoaded({
    required this.weather,
    required this.city,
    required this.history,
  });

  @override
  List<Object?> get props => [weather, city, history]; // Свойства для сравнения
}

// Состояние ошибки
class WeatherError extends WeatherState {
  final String message; // Текст ошибки

  const WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}