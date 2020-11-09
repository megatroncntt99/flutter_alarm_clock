import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/models/MenuType.dart';

class MenuInfo extends ChangeNotifier {
  String title;
  String image;
  MenuType menuType;

  MenuInfo({this.title, this.image, @required this.menuType});

  updateMenuInfo(MenuInfo menuInfo) {
    this.title = menuInfo.title;
    this.image = menuInfo.image;
    this.menuType = menuInfo.menuType;
    notifyListeners();
  }
}

List<MenuInfo> menuItems = [
  MenuInfo(
    title: "Clock",
    image: "assets/clock_icon.png",
    menuType: MenuType.Clock,
  ),
  MenuInfo(
      title: "Alarm", image: "assets/alarm_icon.png", menuType: MenuType.Alarm),
  MenuInfo(
      title: "Timer", image: "assets/timer_icon.png", menuType: MenuType.Timer),
  MenuInfo(
      title: "Stopwatch",
      image: "assets/stopwatch_icon.png",
      menuType: MenuType.StopWatch),
];
