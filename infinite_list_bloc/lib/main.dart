import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_list_bloc/blocs/bloc.dart';
import 'package:infinite_list_bloc/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      builder: (BuildContext context) => PostBloc(httpClient: http.Client())..add(Fetch()),
      child: MaterialApp(
        title: 'Infinte List Bloc',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}