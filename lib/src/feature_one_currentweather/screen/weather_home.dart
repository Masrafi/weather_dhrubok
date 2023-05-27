import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_dr/src/feature_one_currentweather/repo/forecast_repo.dart';
import 'package:task_dr/src/feature_one_currentweather/screen/weather_forecast.dart';
import 'package:task_dr/src/feature_three_internercheck/screen/interner_check.dart';
import 'package:task_dr/utils/color.dart';
import '../../feature_three_internercheck/internet_bloc/internet_cubit.dart';
import '../bloc/forecast_bloc.dart';
import '../bloc/weather_bloc.dart';
import '../repo/repository.dart';
import 'weather_current_location.dart';
import 'weather_place.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String lat, long;
  var color = ColorFactory();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

// This method get current locations lat & long
  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle it as needed
      return;
    }

    // Check for location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permission is denied, handle it as needed
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Location permission is permanently denied, handle it as needed
      return;
    }

    // Retrieve the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(">........................... ${position.longitude}");
    print(">........................... ${position.latitude}");
    // Access the latitude and longitude from the position object
    lat = position.latitude.toString();
    long = position.longitude.toString();

    // Use the latitude and longitude as needed
    print('Latitude: $lat, Longitude: $long');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetCubit(),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const InternetCheck(),
              const Spacer(),
              TextButton(
                onPressed: () {
                  //BlocProvider.of<WeatherBloc>(context).add(WeatherFetch(lat));
                  // Navigator.pushNamed(
                  //   context,
                  //   '/weatherlocation',
                  // arguments: {
                  //   "lat": lat,
                  //   "long": long,
                  // },
                  //);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => WeatherBloc(WeatherRepository()),
                        child: WeatherLocation(
                          lat: lat,
                          long: long,
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 300,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Current Weather"),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                          create: (context) => WeatherBloc(WeatherRepository()),
                          child: const WeatherPlace()),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 300,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Place"), Icon(Icons.arrow_forward)],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => ForecastBloc(ForecastRepository()),
                        child: WeatherForecast(
                          lat: lat,
                          long: long,
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 300,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Weather Forecast"),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
