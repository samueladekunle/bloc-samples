import 'package:flutter/material.dart';
import 'package:timer_bloc/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  final String title;

  HomeScreen({
    this.title
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Stack(
        children: <Widget>[
          WaveBackground(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: Center(
                  child: Timer(),
                ),
              ),
              ActionButtons(),
            ],
          ),
        ],
      ),
    );
  }
}