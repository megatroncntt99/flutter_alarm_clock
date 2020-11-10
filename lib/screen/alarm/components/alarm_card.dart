import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/models/AlarmInfo.dart';
import 'package:intl/intl.dart';

class AlarmCard extends StatelessWidget {
  const AlarmCard({
    Key key,
    @required this.alarmInfo,
  }) : super(key: key);
  final AlarmInfo alarmInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: alarmInfo.colorGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                offset: Offset(3, 3),
                color: alarmInfo.colorGradient.last.withOpacity(0.4),
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
                alarmInfo.description,
                style: TextStyle(color: Colors.white),
              ),
              Spacer(),
              Switch(
                value: alarmInfo.isActive,
                onChanged: (value) {
                  alarmInfo.isActive = value;
                  print(value);
                },
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
                DateFormat("HH:mm").format(alarmInfo.dateTime),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Spacer(),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              )
            ],
          )
        ],
      ),
    );
  }
}
