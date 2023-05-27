import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:task_dr/src/feature_one_currentweather/data/forecast_model.dart';

import '../data/model.dart';

class ForecastRepository {
  Future<ForecastModel> getDataForecast(String lat, String long) async {
    String url =
        "http://api.openweathermap.org/data/2.5/forecast?lat=${lat}&lon=${long}&appid=700c6acf3c04e16f7b91e0a1e414783e";
    Response response = await get(Uri.parse(url));
    try {
      Map<String, dynamic> map = jsonDecode(response.body);
      //print(map);
      print("This is from weather forecast: ${map['list']}");
      return ForecastModel.fromJson(map);
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
