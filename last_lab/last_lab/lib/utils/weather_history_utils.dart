import 'package:shared_preferences/shared_preferences.dart';

// Утилита для работы с историей погоды
class WeatherHistoryUtils {
  // Ключ для хранения истории в SharedPreferences
  static const String _key = 'weather_history';

  // Сохранение новой записи в историю погоды
  static Future<void> saveWeatherEntry(String entry) async {
    // Получаем экземпляр SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    // Загружаем текущую историю или создаем пустой список, если истории нет
    final history = prefs.getStringList(_key) ?? [];
    // Добавляем новую запись в конец списка
    history.add(entry);
    // Сохраняем обновленный список обратно в SharedPreferences
    await prefs.setStringList(_key, history);
  }

  // Загружает и возвращает всю историю запросов погоды
  static Future<List<String>> getHistory() async {
    // Получаем экземпляр SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    // Возвращаем сохраненную историю или пустой список, если истории нет
    return prefs.getStringList(_key) ?? [];
  }

  // Очищает историю погоды
  static Future<void> clearHistory() async {
    // Получаем экземпляр SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    // Удаляем все записи по ключу
    await prefs.remove(_key);
  }
}
