import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:task_dr/src/feature_one_currentweather/data/forecast_model.dart';
import 'package:task_dr/utils/config.dart';

class ForecastRepository {
  Future<ForecastModel> getDataForecast(String lat, String long) async {
    String url =
        "${Config.Forecast_URL}lat=${lat}&lon=${long}&appid=${Config.Api_Key}";
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
