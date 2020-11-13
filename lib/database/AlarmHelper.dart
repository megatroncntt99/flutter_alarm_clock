import 'package:flutter_alarm_clock/models/AlarmInfo.dart';
import 'package:sqflite/sqflite.dart';

String tableAlarm = "alarm";
final String columnId = "id";
final String columnTitle = "title";
final String columnAlarmDateTime = "alarmDateTime";
final String columnIsActive = "isActive";
final String columnGradientColorIndex = "gradientColorIndex";

class AlarmHelper {
  static Database _database;
  static AlarmHelper _alarmHelper;

  AlarmHelper._createInstance();
  factory AlarmHelper() {
    if (_alarmHelper == null) {
      _alarmHelper = AlarmHelper._createInstance();
    }
    return _alarmHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializaDatabase();
    }
    return _database;
  }

  Future<Database> initializaDatabase() async {
    var database;

    final dir = await getDatabasesPath();
    final path = dir + 'alarm.db';
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
create table $tableAlarm ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnAlarmDateTime text not null,
  $columnIsActive integer ,
  $columnGradientColorIndex integer )
''');
      },
    );
    return database;
  }

  Future insertAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;

    await db.transaction((txn) async {
      var id = await txn.insert(tableAlarm, alarmInfo.toMap());
      print(id);

      // int id1 = await txn.rawInsert(
      //     'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
      // print('inserted1: $id1');
    });
  }

  Future<List<AlarmInfo>> getAlarms() async {
    var db = await this.database;
    List<AlarmInfo> alarms = <AlarmInfo>[];
    List<Map> maps = await db.query(
      tableAlarm,
      columns: [
        columnId,
        columnTitle,
        columnAlarmDateTime,
        columnIsActive,
        columnGradientColorIndex,
      ],
    );
    if (maps.length > 0) {
      maps.forEach((map) {
        var item = AlarmInfo.fromMap(map);
        alarms.add(item);
      });
    }

    return alarms;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(AlarmInfo alarmInfo) async {
    var db = await this.database;
    return await db.update(tableAlarm, alarmInfo.toMap(),
        where: '$columnId = ?', whereArgs: [alarmInfo.id]);
  }

  Future dispose() async {
    await this.database
      ..close();

    print("Close Database");
  }
}
