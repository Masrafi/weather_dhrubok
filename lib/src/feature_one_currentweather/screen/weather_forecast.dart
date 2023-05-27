import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_dr/src/feature_one_currentweather/bloc/forecast_bloc.dart';
import 'package:task_dr/src/feature_one_currentweather/bloc/weather_state.dart';
import 'package:task_dr/src/feature_one_currentweather/data/forecast_model.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';

class WeatherForecast extends StatefulWidget {
  var lat, long;
  WeatherForecast({Key? key, this.lat, this.long}) : super(key: key);

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
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
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Text(
                              "Description: ${userList.temp.toString()}",
                              style: const TextStyle(color: Colors.white),
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
            SizedBox(
              height: 300,
              width: 400,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      'Item 1',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      'Item 1',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      'Item 1',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: const Center(
                        child: Text(
                      'Item 1',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
