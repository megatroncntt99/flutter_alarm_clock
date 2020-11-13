import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/database/AlarmHelper.dart';
import 'package:flutter_alarm_clock/models/AlarmInfo.dart';
import 'package:flutter_alarm_clock/theme_data.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

import '../../main.dart';
import 'components/alarm_card.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key key}) : super(key: key);

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  DateTime _alarmTime;
  String _alarmTimeString;
  AlarmHelper _alarmHelper = AlarmHelper();
  Future<List<AlarmInfo>> _alarms;
  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.database.then((value) {
      print("----Initializa Database----");
      loadAlarms();
    });

    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

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
            child: FutureBuilder<List<AlarmInfo>>(
                future: _alarms,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return ListView(
                      // physics: ClampingScrollPhysics(),
                      physics: BouncingScrollPhysics(),

                      children: snapshot.data
                          .map<Widget>(
                        (alarmInfo) => AlarmCard(
                          alarmInfo: alarmInfo,
                          changerActive: (value) {
                            _alarmHelper
                                .update(alarmInfo.copyWith(isActive: value));
                            loadAlarms();
                          },
                          deleteAlarm: () {
                            showModalBottomSheet(
                              clipBehavior: Clip.hardEdge,
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                          "Bạn có muốn xóa báo thức này không?"),
                                      Row(
                                        children: [
                                          InkWell(
                                              child: Text("Xóa"),
                                              onTap: () {
                                                _alarmHelper
                                                    .delete(alarmInfo.id);
                                                Navigator.of(context).pop();
                                                loadAlarms();
                                              }),
                                          InkWell(
                                            child: Text("Hủy"),
                                            onTap: () {
                                              Navigator.of(context);
                                            },
                                          ),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                            _alarmHelper.delete(alarmInfo.id);
                          },
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              onPressed: () {
                                createAlarm(context);
                                // scheduleAlarm(DateTime.now());
                              },
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
                    );

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void scheduleAlarm(DateTime scheduledNotificationDateTime) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'clock',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('clock'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      1,
      'Office',
      'Good morning! Time for office.',
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,

      // uiLocalNotificationDateInterpretation:
      //     UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void createAlarm(BuildContext context) {
    _alarmTimeString = DateFormat("HH:mm").format(DateTime.now());
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      useRootNavigator: true,
      elevation: 20,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      )),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StatefulBuilder(
                builder: (context, setState) {
                  return FlatButton(
                    onPressed: () async {
                      var selectTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (selectTime != null) {
                        var now = DateTime.now();
                        var selectDatetime = DateTime(now.year, now.month,
                            now.day, selectTime.hour, selectTime.minute);

                        _alarmTime = selectDatetime;
                        setState(() {
                          _alarmTimeString = _alarmTimeString =
                              DateFormat("HH:mm").format(selectDatetime);
                        });
                      }
                    },
                    child: Text(
                      _alarmTimeString,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Repeat'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Text('Sound'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                title: Text('Title'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  DateTime scheduleAlarmDateTime;
                  if (_alarmTime.isAfter(DateTime.now()))
                    scheduleAlarmDateTime = _alarmTime;
                  else
                    scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));

                  var alarmInfo = AlarmInfo(
                    alarmDateTime: scheduleAlarmDateTime,
                    gradientColorIndex: Random().nextInt(4),
                    title: 'alarm',
                  );
                  scheduleAlarm(scheduleAlarmDateTime);
                  _alarmHelper.insertAlarm(alarmInfo);
                  Navigator.of(context).pop();
                  loadAlarms();

                  print("insert succress");
                },
                icon: Icon(Icons.alarm),
                label: Text('Save'),
              )
            ],
          ),
        );
      },
    );
  }
}

List<AlarmInfo> alarmItems = <AlarmInfo>[
  AlarmInfo(
    alarmDateTime: DateTime.now().add(Duration(hours: 3)),
    title: "Office",
    gradientColorIndex: 1,
  ),
  AlarmInfo(
    alarmDateTime: DateTime.now().add(Duration(hours: 1, minutes: 30)),
    title: "Test",
    isActive: true,
    gradientColorIndex: 2,
  ),
  AlarmInfo(
    alarmDateTime: DateTime.now().add(Duration(minutes: 30)),
    title: "Study",
    gradientColorIndex: 0,
  ),
];
