class WeatherModel {
  double? temp;
  List<Weather>? weather;
  double? speed;
  int? humidity;
  String? name;

  WeatherModel({this.temp, this.weather, this.speed, this.humidity});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    temp = json['main']['temp'];
    weather = (json['weather'] as List?)!
        .map((s) => Weather.fromJson(Map<String, dynamic>.from(s)))
        .toList();
    speed = json['wind']['speed'];
    humidity = json['main']['humidity'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['description'] = this.weather;
    data['speed'] = this.speed;
    data['humidity'] = this.humidity;
    data['name'] = this.name;
    return data;
  }
}

class Weather {
  String? description;

  Weather({this.description});

  Weather.fromJson(Map<String, dynamic> json) {
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    return data;
  }
}
