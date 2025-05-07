import 'package:shared_preferences/shared_preferences.dart';

// Утилита для работы с историей вычислений
class CalcHistoryUtils {
  // Ключ для хранения истории вычислений в SharedPreferences
  static const String _key = 'calc_history';

  // Загружает историю вычислений из хранилища
  static Future<List<String>> loadHistory() async {
    // Получаем экземпляр SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    // Получаем список строк по ключу или возвращаем пустой список,
    // если по этому ключу ничего нет
    return prefs.getStringList(_key) ?? [];
  }

  // Сохраняет новую запись в истории вычислений
  static Future<void> saveEntry(String entry) async {
    final prefs = await SharedPreferences.getInstance();
    // Загружаем текущую историю или создаем пустой список
    final current = prefs.getStringList(_key) ?? [];
    // Вставляем новую запись в начало списка
    current.insert(0, entry); 
    // Сохраняем обновленный список обратно в SharedPreferences
    await prefs.setStringList(_key, current);
  }

  // Полностью очищает историю вычислений
  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    // Удаляем все записи по ключу
    await prefs.remove(_key);
  }
}
