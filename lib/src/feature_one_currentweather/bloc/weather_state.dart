import 'package:equatable/equatable.dart';

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

class WeatherIsNotLoaded extends WeatherState {}

class WeatherErrorState extends WeatherState {}
