import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter_bloc/blocs/bloc.dart';
import 'package:counter_bloc/widgets/counter_text.dart';
import 'package:counter_bloc/widgets/action_button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      builder: (BuildContext context) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: CounterText(),
        ),
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: CounterEvent.values.map((CounterEvent event) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: ActionButton(
                event: event,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}