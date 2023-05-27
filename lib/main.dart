import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_dr/route/route.dart';
import 'src/feature_two_splashscreen/screen/scplash_screen.dart';
import 'src/feature_two_splashscreen/spalsh_bloc/splash_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.onGenerateRoute,
      home: BlocProvider(
        create: (context) => SplashBloc(),
        child: SplashScreen(),
      ),
    );
  }
}
