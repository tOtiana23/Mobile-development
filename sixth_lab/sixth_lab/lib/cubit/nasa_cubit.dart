import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sixth_lab/requests/api.dart';
import 'nasa_state.dart';

class NasaCubit extends Cubit<NasaState> {
  List<dynamic> _photos = [];

  NasaCubit() : super(NasaLoadingState());

  void loadData() async {
    try {
      emit(NasaLoadingState());
      _photos = await getNasaData();
      emit(NasaLoadedState(_photos));
    } catch (e) {
      emit(NasaErrorState(e.toString()));
    }
  }

  void showPhotoDetail(Map<String, dynamic> photo) {
    emit(NasaPhotoDetailState(photo));
  }

  void goBack() {
    emit(NasaLoadedState(_photos));
  }
}
