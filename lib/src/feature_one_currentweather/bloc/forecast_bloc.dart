import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/forecast_repo.dart';
import '../repo/repository.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class ForecastBloc extends Bloc<WeatherEvent, WeatherState> {
  ForecastRepository forecastRepository;
  ForecastBloc(this.forecastRepository) : super(WeatherNotSearched()) {
    on<WeatherFetch>((event, emit) async {
      if (event is WeatherFetch) {
        emit(WeatherIsLoading());
        print(
            ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${event.lat}");
        try {
          final user =
              await forecastRepository.getDataForecast(event.lat, event.long);
          emit(ForecastIsLoaded(user));
        } catch (e) {
          print("Forecast: ${e.toString()}");
          emit(WeatherErrorState());
        }
      } else if (event is WeatherReset) {
        emit(WeatherNotSearched());
      }
    });
  }
}
