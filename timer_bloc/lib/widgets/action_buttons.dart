import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_bloc/blocs/bloc.dart';

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      condition: (TimerState previousState, TimerState currentState) {
        return previousState.runtimeType != currentState.runtimeType;
      },
      builder: (BuildContext context, TimerState state) {
        final TimerBloc bloc = BlocProvider.of<TimerBloc>(context);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _mapStateToActionButtons(bloc: bloc, state: state),
        );
      },
    );
  }

  List<Widget> _mapStateToActionButtons({TimerBloc bloc, TimerState state}) {
    if (state is Ready) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => bloc.dispatch(Start(duration: state.duration)),
        ),
      ];
    }
    
    if (state is Running) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () => bloc.dispatch(Pause()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => bloc.dispatch(Reset()),
        ),
      ];
    }

    if (state is Paused) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => bloc.dispatch(Resume()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => bloc.dispatch(Reset()),
        ),
      ];
    }

    if (state is Finished) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => bloc.dispatch(Reset()),
        ),
      ];
    }

    return [];
  }
}