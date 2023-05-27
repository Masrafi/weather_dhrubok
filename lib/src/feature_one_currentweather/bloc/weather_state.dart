import 'package:equatable/equatable.dart';
import 'package:task_dr/src/feature_one_currentweather/data/forecast_model.dart';

import '../data/model.dart';

class WeatherState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WeatherNotSearched extends WeatherState {}

class WeatherIsLoading extends WeatherState {}

class WeatherIsLoaded extends WeatherState {
  final weather;

  WeatherIsLoaded(this.weather);

  WeatherModel get getWeather => weather;

  @override
  // TODO: implement props
  List<Object> get props => [weather];
}

class ForecastIsLoaded extends WeatherState {
  final forecast;

  ForecastIsLoaded(this.forecast);

  ForecastModel get getWeather => forecast;

  @override
  // TODO: implement props
  List<Object> get props => [forecast];
}

class WeatherIsNotLoaded extends WeatherState {}

class WeatherErrorState extends WeatherState {}
