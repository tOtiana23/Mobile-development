import 'package:url_launcher/url_launcher.dart';

/// Открывает карту ветров в браузере
Future<void> openWindMap() async {
    // Создаем Uri-объект для целевого URL карты ветров
  // Координаты 50.0, 90.0 - центр карты, 5 - уровень масштабирования
  final Uri url = Uri.parse('https://www.windy.com/?50.0,90.0,5');

  try {
    // Пытаемся открыть URL с помощью механизма запуска URL
    await launchUrl(
      url,
      // Указываем режим открытия - в браузере
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    print('Не удалось открыть $url');
  }
}
