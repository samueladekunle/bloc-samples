import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter_bloc/blocs/bloc.dart';

class CounterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      builder: (BuildContext context, int state) {
        return Text(
          '$state',
          style: TextStyle(fontSize: 24.0),
        );
      },
    );
  }
}