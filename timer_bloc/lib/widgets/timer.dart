import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_bloc/blocs/bloc.dart';

class Timer extends StatelessWidget {
  static const TextStyle timerTextStyle = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (BuildContext context,TimerState state) {
        final String minutesStr = ((state.duration / 60) % 60)
            .floor()
            .toString()
            .padLeft(2, '0');
        final String secondsStr =
            (state.duration % 60).floor().toString().padLeft(2, '0');

        return Text(
          '$minutesStr:$secondsStr',
          style: Timer.timerTextStyle,
        );
      },
    );
  }
}