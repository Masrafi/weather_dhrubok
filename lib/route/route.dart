import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../src/feature_one_weather/bloc/weather_bloc.dart';
import '../src/feature_one_weather/repo/repository.dart';
import '../src/feature_one_weather/screen/weather_current_location.dart';
import '../src/feature_one_weather/screen/weather_place.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/weatherplace":
        // Map<String, dynamic> arguments =
        //     settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => WeatherBloc(WeatherRepository()),
            child: WeatherLocation(),
          ),
        );

      case "/weatherlocation":
        return MaterialPageRoute(
          builder: (context) => WeatherPlace(),
        );
    }
  }
}
