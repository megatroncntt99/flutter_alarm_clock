import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/models/MenuInfo.dart';
import 'package:flutter_alarm_clock/models/MenuType.dart';
import 'package:provider/provider.dart';

import 'screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Alarm Clock',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "avenir",
      ),
      home: ChangeNotifierProvider<MenuInfo>(
        create: (context) => MenuInfo(menuType: MenuType.Clock),
        builder: (context, child) {
          return HomeScreen();
        },
      ),
    );
  }
}
