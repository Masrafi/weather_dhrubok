import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_dr/utils/color.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';
import '../data/model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geocoding_platform_interface/geocoding_platform_interface.dart';

class WeatherPlace extends StatefulWidget {
  const WeatherPlace({Key? key}) : super(key: key);

  @override
  State<WeatherPlace> createState() => _WeatherPlaceState();
}

class _WeatherPlaceState extends State<WeatherPlace> {
  var placeController = TextEditingController();
  late String lat, long;
  var color = ColorFactory();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //This method convert location to lat & long
  Future<void> getLatLngFromPlaceName(String placeName) async {
    try {
      List<Location> locations = await locationFromAddress(placeName);
      if (locations != null && locations.isNotEmpty) {
        lat = locations[0].latitude.toString();
        long = locations[0].longitude.toString();
        print('Latitude: $lat, Longitude: $long');
        BlocProvider.of<WeatherBloc>(context)
            .add(WeatherFetch(lat: lat, long: long));
      } else {
        print('No location found for the given place name');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
          if (state is WeatherNotSearched) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: placeController,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // BlocProvider.of<WeatherBloc>(context)
                    //     .add(WeatherFetch(placeController.text));
                    getLatLngFromPlaceName(placeController.text);
                    placeController.clear();
                    await Future.delayed(const Duration(seconds: 6));
                  },
                  child: const Text("Search"),
                ),
              ],
            );
          }
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
                  style: TextStyle(color: color.whiteW, fontSize: 16),
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
                          style: TextStyle(color: color.whiteW),
                        ),
                      );
                    },
                  ),
                ),
                const Spacer(),
              ],
            );
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
        }),
      ),
    );
  }
}
