import 'package:last_lab/model/wind_direction_model.dart';
import 'package:last_lab/model/wind_speed_model.dart';

class Wind {
  WindDirection? direction;
  WindSpeed? speed;

  Wind({this.direction, this.speed});

  Wind.fromJson(Map<String, dynamic> json) {
    direction = json['Direction'] != null
        ? WindDirection.fromJson(json['Direction'])
        : null;
    speed = json['Speed'] != null ? WindSpeed.fromJson(json['Speed']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.direction != null) {
      data['Direction'] = this.direction!.toJson();
    }
    if (this.speed != null) {
      data['Speed'] = this.speed!.toJson();
    }
    return data;
  }
}