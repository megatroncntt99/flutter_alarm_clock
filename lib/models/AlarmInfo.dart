import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/theme_data.dart';

class AlarmInfo {
  DateTime dateTime;
  String description;
  bool isActive;
  List<Color> colorGradient;
  AlarmInfo(
    this.dateTime, {
    this.description,
    this.isActive = false,
    this.colorGradient,
  });
}

List<AlarmInfo> alarmItem = <AlarmInfo>[
  AlarmInfo(
    DateTime.now().add(Duration(hours: 3)),
    description: "Office",
    colorGradient: GradientColors.sky,
  ),
  AlarmInfo(
    DateTime.now().add(Duration(hours: 1, minutes: 30)),
    description: "Test",
    isActive: true,
    colorGradient: GradientColors.sea,
  ),
  AlarmInfo(
    DateTime.now().add(Duration(hours: 4, minutes: 30)),
    description: "Study",
    colorGradient: GradientColors.mango,
  ),
];
