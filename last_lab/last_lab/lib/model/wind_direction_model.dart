class WindDirection {
  int? degrees;
  String? localized;
  String? english;

  WindDirection({this.degrees, this.localized, this.english});

  WindDirection.fromJson(Map<String, dynamic> json) {
    degrees = json['Degrees'];
    localized = json['Localized'];
    english = json['English'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Degrees'] = this.degrees;
    data['Localized'] = this.localized;
    data['English'] = this.english;
    return data;
  }
}