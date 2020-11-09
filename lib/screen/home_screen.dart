import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/components/menu_button.dart';
import 'package:flutter_alarm_clock/screen/components/clock_view.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _dateTime = DateTime.now();
  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) {
      this.setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var formattedTime = DateFormat("HH:mm").format(_dateTime);
    var formattedDate = DateFormat("EEE, d MMM").format(_dateTime);
    var timezoneString = _dateTime.timeZoneOffset.toString().split(".").first;
    String offsetSign;
    if (!timezoneString.startsWith("-")) {
      offsetSign = "+";
    }
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuButton(
                  title: "Clock", image: "assets/clock_icon.png", press: () {}),
              MenuButton(
                  title: "Alarm", image: "assets/alarm_icon.png", press: () {}),
              MenuButton(
                  title: "Timer", image: "assets/timer_icon.png", press: () {}),
              MenuButton(
                  title: "Stopwatch",
                  image: "assets/stopwatch_icon.png",
                  press: () {}),
            ],
          ),
          VerticalDivider(
            color: Colors.white54,
            width: 2,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(
                      "Clock",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedTime,
                          style: TextStyle(
                              fontSize: 64,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.center,
                      child: ClockView(
                        size: MediaQuery.of(context).size.height * 0.3,
                        dateTime: _dateTime,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Timezone",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.language,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "UTC ${offsetSign + timezoneString}",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
