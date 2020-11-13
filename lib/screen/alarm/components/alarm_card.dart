import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/database/AlarmHelper.dart';
import 'package:flutter_alarm_clock/models/AlarmInfo.dart';
import 'package:intl/intl.dart';

import '../../../theme_data.dart';

class AlarmCard extends StatelessWidget {
  const AlarmCard({
    Key key,
    @required this.alarmInfo,
    @required this.deleteAlarm,
    @required this.changerActive,
  }) : super(key: key);
  final AlarmInfo alarmInfo;
  final Function(bool) changerActive;
  final Function deleteAlarm;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: GradientTemplate
                .gradientTemplate[alarmInfo.gradientColorIndex].colors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                offset: Offset(3, 3),
                color: GradientTemplate
                    .gradientTemplate[alarmInfo.gradientColorIndex].colors.last
                    .withOpacity(0.4),
                blurRadius: 8,
                spreadRadius: 2)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.label,
                color: Colors.white,
                size: 24,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                alarmInfo.title,
                style: TextStyle(color: Colors.white),
              ),
              Switch(
                value: alarmInfo.isActive ?? false,
                onChanged: changerActive,
                activeColor: Colors.white,
              ),
            ],
          ),
          Text(
            "Mon-Fri",
            style: TextStyle(color: Colors.white),
          ),
          Row(
            children: [
              Text(
                DateFormat("HH:mm aa").format(alarmInfo.alarmDateTime),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                ),
                onPressed: deleteAlarm,
              )
            ],
          )
        ],
      ),
    );
  }
}
