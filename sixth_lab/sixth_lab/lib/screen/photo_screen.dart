import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/nasa_cubit.dart';
import '../cubit/nasa_state.dart';
import '../widgets/photo_list.dart';
import '../widgets/photo_detail.dart';

class PhotoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Фото марсохода')),
      body: BlocBuilder<NasaCubit, NasaState>(
        // В зависимости от состояния строим определенный интерфейс
        builder: (context, state) {
          if (state is NasaLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NasaErrorState) {
            return Center(child: Text('Ошибка: ${state.message}'));
          } else if (state is NasaLoadedState) {
            return PhotoList(photos: state.photos);
          } else if (state is NasaPhotoDetailState) {
            return PhotoDetail(photo: state.photo);
          } else {
            return Center(child: Text('Неизвестное состояние'));
          }
        },
      ),
    );
  }
}