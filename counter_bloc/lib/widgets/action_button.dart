import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter_bloc/blocs/bloc.dart';

class ActionButton extends StatelessWidget {
  ActionButton({
    this.event,
  });

  final CounterEvent event;

  @override
  Widget build(BuildContext context) {
    final CounterBloc bloc = BlocProvider.of<CounterBloc>(context);

    return FloatingActionButton(
      child: Icon(
        event == CounterEvent.increment ? Icons.add : Icons.remove
      ),
      onPressed: () => bloc.dispatch(event),
    );
  }
}