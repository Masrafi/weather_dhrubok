import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../feature_one_weather/screen/weather_home.dart';
import '../spalsh_bloc/splash_bloc.dart';
import '../spalsh_bloc/splash_event.dart';
import '../spalsh_bloc/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SplashBloc>(context).add(SetSplash());
    return Scaffold(
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoadedState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          }
        },
        builder: (context, state) {
          if (state is SplashLoadingState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 15, right: 15),
                //   child: Image(
                //     image: AssetImage(
                //       "assets/logo-02.png",
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                Center(
                    child: TypewriterAnimatedTextKit(
                  text: ['Dhrubok'],
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                )),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
