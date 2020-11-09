import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/components/menu_button.dart';
import 'package:flutter_alarm_clock/models/MenuInfo.dart';
import 'package:flutter_alarm_clock/models/MenuType.dart';
import 'package:provider/provider.dart';

import 'clock/clock_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map((e) => MenuButton(
                      menuInfo: e,
                    ))
                .toList(),
          ),
          VerticalDivider(
            color: Colors.white54,
            width: 2,
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (context, value, child) {
                switch (value.menuType) {
                  case MenuType.Clock:
                    return ClockScreen();
                    break;

                  case MenuType.Alarm:
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Alarm",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                    break;
                  case MenuType.Timer:
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Timer",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                    break;
                  case MenuType.StopWatch:
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Stop Watch",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                    break;
                  default:
                    return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
