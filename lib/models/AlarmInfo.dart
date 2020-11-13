import 'dart:convert';

class AlarmInfo {
  final int id;
  final String title;
  final DateTime alarmDateTime;
  final bool isActive;
  final int gradientColorIndex;
  AlarmInfo({
    this.id,
    this.title,
    this.alarmDateTime,
    this.isActive = false,
    this.gradientColorIndex,
  });

  AlarmInfo copyWith({
    int id,
    String title,
    DateTime alarmDateTime,
    bool isActive,
    int gradientColorIndex,
  }) {
    return AlarmInfo(
      id: id ?? this.id,
      title: title ?? this.title,
      alarmDateTime: alarmDateTime ?? this.alarmDateTime,
      isActive: isActive ?? this.isActive,
      gradientColorIndex: gradientColorIndex ?? this.gradientColorIndex,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'alarmDateTime': alarmDateTime.toIso8601String(),
      'isActive': isActive ? 1 : 0,
      'gradientColorIndex': gradientColorIndex,
    };
  }

  factory AlarmInfo.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AlarmInfo(
      id: map['id'],
      title: map['title'],
      alarmDateTime: DateTime.parse(map['alarmDateTime']),
      isActive: map['isActive'] == 1 ? true : false,
      gradientColorIndex: map['gradientColorIndex'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AlarmInfo.fromJson(String source) =>
      AlarmInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AlarmInfo(id: $id, title: $title, alarmDateTime: $alarmDateTime, isActive: $isActive, gradientColorIndex: $gradientColorIndex)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AlarmInfo &&
        o.id == id &&
        o.title == title &&
        o.alarmDateTime == alarmDateTime &&
        o.isActive == isActive &&
        o.gradientColorIndex == gradientColorIndex;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        alarmDateTime.hashCode ^
        isActive.hashCode ^
        gradientColorIndex.hashCode;
  }
}
