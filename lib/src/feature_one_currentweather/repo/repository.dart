import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';

import '../data/model.dart';

class WeatherRepository {
  Future<WeatherModel> getData(String lat, String long) async {
    String url =
        "http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&appid=700c6acf3c04e16f7b91e0a1e414783e";
    Response response = await get(Uri.parse(url));
    try {
      Map<String, dynamic> map = jsonDecode(response.body);
      //print(map['main']['temp'].runtimeType);
      return WeatherModel.fromJson(map);
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
