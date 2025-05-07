import 'package:last_lab/model/temperature_model.dart';
import 'package:last_lab/model/wind_model.dart';

class WeatherModel {
  String? localObservationDateTime;
  int? epochTime;
  String? description;
  int? weatherIcon;
  bool? hasPrecipitation;
  dynamic precipitationType;
  bool? isDayTime;
  Temperature? temperature;
  String? mobileLink;
  String? link;
  Wind? wind; // Добавим поле для ветра

  String? get iconUrl => weatherIcon != null
      ? 'https://developer.accuweather.com/sites/default/files/${weatherIcon! < 10 ? '0$weatherIcon' : '$weatherIcon'}-s.png'
      : null;

  WeatherModel({
    this.localObservationDateTime,
    this.epochTime,
    this.description,
    this.weatherIcon,
    this.hasPrecipitation,
    this.precipitationType,
    this.isDayTime,
    this.temperature,
    this.mobileLink,
    this.link,
    this.wind, // Добавим параметр для ветра
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      localObservationDateTime: json['LocalObservationDateTime'],
      epochTime: json['EpochTime'],
      description: json['WeatherText'],
      weatherIcon: json['WeatherIcon'],
      hasPrecipitation: json['HasPrecipitation'],
      precipitationType: json['PrecipitationType'],
      isDayTime: json['IsDayTime'],
      temperature: json['Temperature'] != null
          ? Temperature.fromJson(json['Temperature'])
          : null,
      mobileLink: json['MobileLink'],
      link: json['Link'],
      wind: json['Wind'] != null ? Wind.fromJson(json['Wind']) : null, // Получаем данные о ветре
    );
  }
}
