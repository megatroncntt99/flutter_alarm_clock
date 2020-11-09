import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/screen/components/clock_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Container(
        alignment: Alignment.center,
        child: ClockView(),
      ),
    );
  }
}
