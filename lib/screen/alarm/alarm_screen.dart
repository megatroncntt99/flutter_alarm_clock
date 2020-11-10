import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/models/AlarmInfo.dart';
import 'package:flutter_alarm_clock/theme_data.dart';

import 'components/alarm_card.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Alarm",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(
            child: ListView(
              // physics: ClampingScrollPhysics(),
              physics: BouncingScrollPhysics(),

              children: alarmItem
                  .map<Widget>(
                (alarmInfo) => AlarmCard(
                  alarmInfo: alarmInfo,
                ),
              )
                  .followedBy([
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(24),
                  dashPattern: [5, 4.5],
                  strokeWidth: 2,
                  color: Colors.white,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColors.clockBG,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      highlightColor: CustomColors.menuBackgroundColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/add_alarm.png",
                            scale: 1.5,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Add Alarm",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ]).toList(),
            ),
          ),
        ],
      ),
    );
  }
}