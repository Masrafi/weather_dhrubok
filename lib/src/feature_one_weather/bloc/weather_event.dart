import 'package:equatable/equatable.dart';

class WeatherEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WeatherFetch extends WeatherEvent {
  late String lat, long;

  WeatherFetch({required this.lat, required this.long});

  @override
  // TODO: implement props
  List<Object> get props => [lat, long];
}

class WeatherReset extends WeatherEvent {}
