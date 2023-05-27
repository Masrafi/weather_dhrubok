import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_dr/src/feature_one_currentweather/bloc/forecast_bloc.dart';
import 'package:task_dr/src/feature_one_currentweather/bloc/weather_state.dart';
import 'package:task_dr/src/feature_one_currentweather/data/forecast_model.dart';
import '../../../utils/color.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';

class WeatherForecast extends StatefulWidget {
  var lat, long;
  WeatherForecast({Key? key, this.lat, this.long}) : super(key: key);

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  var color = ColorFactory();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ForecastBloc>(context).add(WeatherFetch(
      lat: widget.lat,
      long: widget.long,
    ));
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.png"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: const Text(
                "Weather Forecast",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            SizedBox(
              height: 300,
              width: 500,
              child: BlocBuilder<ForecastBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherIsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ForecastIsLoaded) {
                    ForecastModel userList = state.getWeather;

                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 200,
                            height: 300,
                            margin: const EdgeInsets.only(
                              right: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.2),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Spacer(),
                                Center(
                                    child: Text(
                                  "Date: ${userList.list![index].dtTxt!.substring(0, 11).toString()}",
                                  style: TextStyle(
                                      fontSize: 18, color: color.blackB),
                                )),
                                const Spacer(),
                                Center(
                                  child: Text(
                                    "Tempreture: ${userList.list?[index].main?.temp.toString()}",
                                    style: TextStyle(color: color.blackB),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Text(
                                    "Icon: ${userList.list?[index].weather.toString()}",
                                    style: TextStyle(color: color.blackB),
                                  ),
                                ),
                                const Spacer()
                              ],
                            ),
                          );
                        });
                  }
                  if (state is WeatherErrorState) {
                    return const Center(
                      child: Text(
                        "Error",
                        style: TextStyle(color: Colors.black, fontSize: 50),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
