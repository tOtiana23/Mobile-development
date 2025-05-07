import 'package:last_lab/model/imperial_model.dart';
import 'package:last_lab/model/metric_model.dart';

class Temperature {
  Metric? metric;
  Imperial? imperial;

  Temperature({this.metric, this.imperial});

  Temperature.fromJson(Map<String, dynamic> json) {
    metric =
        json['Metric'] != null ? new Metric.fromJson(json['Metric']) : null;
    imperial = json['Imperial'] != null
        ? new Imperial.fromJson(json['Imperial'])
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