import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../internet_bloc/internet_cubit.dart';

class InternetCheck extends StatelessWidget {
  const InternetCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state == InternetState.Gained) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Internet connected'),
            ),
          );
        } else if (state == InternetState.Lost) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Internet not connected'),
            ),
          );
        }
      },
      builder: (context, state) {
        return Container();
      },
    );
  }
}
