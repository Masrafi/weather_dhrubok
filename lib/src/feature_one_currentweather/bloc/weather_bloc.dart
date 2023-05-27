import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/repository.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepo;
  WeatherBloc(this.weatherRepo) : super(WeatherNotSearched()) {
    on<WeatherFetch>((event, emit) async {
      if (event is WeatherFetch) {
        emit(WeatherIsLoading());
        print(
            ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${event.lat}");
        try {
          final user = await weatherRepo.getData(event.lat, event.long);
          emit(WeatherIsLoaded(user));
        } catch (e) {
          print(e.toString());
          emit(WeatherErrorState());
        }
      } else if (event is WeatherReset) {
        emit(WeatherNotSearched());
      }
    });
  }
}
