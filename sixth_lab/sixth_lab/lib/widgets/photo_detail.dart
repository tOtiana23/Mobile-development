import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/nasa_cubit.dart';

class PhotoDetail extends StatelessWidget {
  // Объект, содержащий данные фотографии
  final Map<String, dynamic> photo;

  const PhotoDetail({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Загружаем изображение фотографии по URL
        Image.network(photo['img_src']),
        
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Отображаем ID фотографии
              Text('ID: ${photo['id']}'),
              // Отображаем дату на Земле, когда была сделана фотография
              Text('Дата на Земле: ${photo['earth_date']}'),
              // Отображаем полное название камеры, которая сделала снимок
              Text('Камера: ${photo['camera']['full_name']}'),
              // Отображаем имя марсохода, который сделал снимок
              Text('Марсоход: ${photo['rover']['name']}'),
              // Отображаем статус марсохода
              Text('Статус: ${photo['rover']['status']}'),
            ],
          ),
        ),
        
        // Кнопка для возврата на предыдущий экран
        ElevatedButton(
          onPressed: () => context.read<NasaCubit>().goBack(),
          child: Text('Назад'),
        ),
      ],
    );
  }
}

