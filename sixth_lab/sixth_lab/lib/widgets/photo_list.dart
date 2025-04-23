import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/nasa_cubit.dart';

class PhotoList extends StatelessWidget {
  // Список фотографий, переданный в виджет
  final List<dynamic> photos;

  const PhotoList({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    // Создание списка фотографий с помощью ListView.builder
    // Создает элементы списка по мере их необходимости. Это означает, что только видимые элементы и несколько ближайших к ним будут созданы и загружены в память
    return ListView.builder(
      // Установка количества элементов в списке равным длине списка photos
      itemCount: photos.length,
      // Функция для построения каждого элемента списка
      itemBuilder: (context, index) {
        // Получение фотографии по индексу
        final photo = photos[index];
        return InkWell(
          // Обработка нажатия на элемент списка
          onTap: () => context.read<NasaCubit>().showPhotoDetail(photo),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Загрузка изображения из сети по URL, указанному в 'img_src'
                Image.network(photo['img_src']),
                // Отображение ID фотографии под изображением
                Text('ID: ${photo['id']}'),
              ],
            ),
          ),
        );
      },
    );
  }
}

