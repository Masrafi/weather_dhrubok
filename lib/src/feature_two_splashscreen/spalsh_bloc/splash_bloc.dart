import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<SetSplash>((event, emit) async {
      emit(SplashLoadingState());
      await Future.delayed(const Duration(seconds: 3));
      emit(SplashLoadedState());
    });
  }
}
