import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_dr/utils/color.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';
import '../data/model.dart';

class WeatherLocation extends StatefulWidget {
  var lat, long;
  WeatherLocation({Key? key, this.lat, this.long}) : super(key: key);

  @override
  State<WeatherLocation> createState() => _WeatherLocationState();
}

class _WeatherLocationState extends State<WeatherLocation> {
  var placeController = TextEditingController();
  var color = ColorFactory();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.lat);
    print(widget.long);
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WeatherBloc>(context).add(WeatherFetch(
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
        child:
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is WeatherIsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WeatherIsLoaded) {
            WeatherModel userList = state.getWeather;
            print("This is Data: $userList");

            return Column(
              children: [
                const Spacer(),
                Text(
                  "Place Name: ${userList.name.toString()}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Temperature: ${(userList.temp! - 273.15).round().toString()}c OR ${(1.8 * (userList.temp! - 273) + 32).round()}f",
                  style: TextStyle(color: color.whiteW, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Speed: ${userList.speed.toString()}",
                  style: TextStyle(color: color.whiteW, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Humidity: ${userList.humidity.toString()}",
                  style: TextStyle(color: color.whiteW, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Pressure: ${userList.pressure.toString()}",
                  style: TextStyle(color: color.whiteW, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Visibility: ${userList.visibility.toString()}",
                  style: TextStyle(color: color.whiteW, fontSize: 16),
                ),
                Expanded(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: userList.weather!.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Text(
                            "Description: ${userList.weather![index].description.toString()}",
                            style: TextStyle(
                              color: color.whiteW,
                            ),
                          ),
                        );
                      }),
                ),
                const Spacer(),
              ],
            );
          }
          if (state is WeatherErrorState) {
            return Center(
              child: Text(
                "Error",
                style: TextStyle(color: color.blackB, fontSize: 50),
              ),
            );
          }
          return Container();
        }),
      ),
    );
  }
}
