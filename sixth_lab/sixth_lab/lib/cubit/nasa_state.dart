abstract class NasaState {}

class NasaLoadingState extends NasaState {}

class NasaLoadedState extends NasaState {
  final List<dynamic> photos;
  NasaLoadedState(this.photos);
}

class NasaErrorState extends NasaState {
  final String message;
  NasaErrorState(this.message);
}

class NasaPhotoDetailState extends NasaState {
  final Map<String, dynamic> photo;
  NasaPhotoDetailState(this.photo);
}
