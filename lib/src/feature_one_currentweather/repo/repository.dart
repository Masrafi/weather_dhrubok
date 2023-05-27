import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';

import '../../../utils/config.dart';
import '../data/model.dart';

class WeatherRepository {
  Future<WeatherModel> getData(String lat, String long) async {
    String url =
        "${Config.Weather_URL}lat=${lat}&lon=${long}&appid=${Config.Api_Key}";
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
