import 'package:last_lab/model/imperial_model.dart';
import 'package:last_lab/model/metric_model.dart';

class WindSpeed {
  Metric? metric;
  Imperial? imperial;

  WindSpeed({this.metric, this.imperial});

  WindSpeed.fromJson(Map<String, dynamic> json) {
    metric = json['Metric'] != null ? Metric.fromJson(json['Metric']) : null;
    imperial = json['Imperial'] != null
        ? Imperial.fromJson(json['Imperial'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metric != null) {
      data['Metric'] = this.metric!.toJson();
    }
    if (this.imperial != null) {
      data['Imperial'] = this.imperial!.toJson();
    }
    return data;
  }
}