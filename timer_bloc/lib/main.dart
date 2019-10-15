import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_bloc/blocs/bloc.dart';
import 'package:timer_bloc/data/ticker.dart';
import 'package:timer_bloc/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String _title = 'Flutter Timer';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimerBloc>(
      builder: (BuildContext context) => TimerBloc(ticker: Ticker()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(109, 234, 255, 1),
          accentColor: Color.fromRGBO(72, 74, 126, 1),
          brightness: Brightness.dark,
        ),
        title: _title,
        routes: {
          '/': (BuildContext context) => HomeScreen(title: _title,),
        },
      ),
    );
  }
}