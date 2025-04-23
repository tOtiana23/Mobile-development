import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getNasaData() async {
  // Я взяла другой марсоход, потому что с моим марсоходом opportunity ничего не работало, его img_src вел на сайт, а не на картинку
  // Такая же проблема была обнаружена с марсоходом spirit, а с perseverance и сuriosity всё работает
  // Вот пример, куда вёл img_src марсохода opportunity
  // https://science.nasa.gov/mission/mars-exploration-rovers-spirit-and-opportunity/
  final url = Uri.parse(
    'http://api.nasa.gov/mars-photos/api/v1/rovers/perseverance/photos?sol=100&api_key=sBXZl0sr3Ko1f8CLR8nO8yWUa2XrNbx4lKdgfPfj',
  );
  // Отправляем GET-запрос по указанному URL
  final response = await http.get(url);

  // Проверяем статус ответа. Если статус 200, значит запрос успешен
  if (response.statusCode == 200) {
    // Декодируем JSON-ответ
    final data = json.decode(response.body); 
    return data['photos']; // Возвращаем список фото
  } else {
    throw Exception('Ошибка: ${response.statusCode}');
  }
}