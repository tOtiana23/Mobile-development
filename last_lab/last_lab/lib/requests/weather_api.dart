import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:last_lab/model/weather_model.dart';

// Класс для работы с API погодного сервиса AccuWeather
class WeatherApi {
  // Ключ API для доступа к сервису AccuWeather
  final String apiKey = 'rtTT5PcGTkA6kXLvytbDZh19zchqo8om';
  // Ключ локации, для которой запрашивается погода
  final String locationKey;

  WeatherApi(this.locationKey);

  // Получает текущие погодные данные для указанной локации
  Future<WeatherModel?> getCurrentWeather() async {
    try {
      // Формируем URL для запроса текущей погоды
      final url = Uri.parse(
        'http://dataservice.accuweather.com/currentconditions/v1/$locationKey?apikey=$apiKey&language=ru-ru&details=true');
      // Выполняем GET-запрос
      final response = await http.get(url);

      // Обрабатываем успешный ответ
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Парсим JSON
        return WeatherModel.fromJson(data[0]); // Создаем модель из первого элемента массива
      } else {
        // Логируем ошибку HTTP
        print('Ошибка запроса: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Логируем исключения при выполнении запроса
      print('Исключение при запросе: $e');
      return null;
    }
  }

  // Получаем название города по locationKey
  Future<String?> getCityName() async {
    try {
      // Формируем URL для запроса информации о локации
      final url = Uri.parse(
        'http://dataservice.accuweather.com/locations/v1/$locationKey?apikey=$apiKey&language=ru-ru');
      // Выполняем GET-запрос
      final response = await http.get(url);

    // Обрабатываем успешный ответ
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body); // Парсим JSON
        return data['LocalizedName']; // Извлекаем название города
      } else {
        print('Ошибка при получении города: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Исключение при получении города: $e');
      return null;
    }
  }
}