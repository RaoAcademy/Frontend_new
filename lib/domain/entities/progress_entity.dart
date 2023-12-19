import 'package:rao_academy/domain/entities/home_entity.dart';

class Progress {
  Progress(
      {this.friday,
      this.monday,
      this.saturday,
      this.sunday,
      this.thursday,
      this.tuesday,
      this.wednesday});

  Progress.fromJson(Map<String, dynamic> json) {
    friday = json['Fri'] != null
        ? DaySubject.fromJson(json['Fri'] as Map<String, dynamic>)
        : null;
    monday = json['Mon'] != null
        ? DaySubject.fromJson(json['Mon'] as Map<String, dynamic>)
        : null;
    saturday = json['Sat'] != null
        ? DaySubject.fromJson(json['Sat'] as Map<String, dynamic>)
        : null;
    sunday = json['Sun'] != null
        ? DaySubject.fromJson(json['Sun'] as Map<String, dynamic>)
        : null;
    thursday = json['Thu'] != null
        ? DaySubject.fromJson(json['Thu'] as Map<String, dynamic>)
        : null;
    tuesday = json['Tue'] != null
        ? DaySubject.fromJson(json['Tue'] as Map<String, dynamic>)
        : null;
    wednesday = json['Wed'] != null
        ? DaySubject.fromJson(json['Wed'] as Map<String, dynamic>)
        : null;
  }

  DaySubject? friday;
  DaySubject? monday;
  DaySubject? saturday;
  DaySubject? sunday;
  DaySubject? thursday;
  DaySubject? tuesday;
  DaySubject? wednesday;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (friday != null) {
      data['Fri'] = friday!.toJson();
    }
    if (monday != null) {
      data['Mon'] = monday!.toJson();
    }
    if (saturday != null) {
      data['Sat'] = saturday!.toJson();
    }
    if (sunday != null) {
      data['Sun'] = sunday!.toJson();
    }
    if (thursday != null) {
      data['Thu'] = thursday!.toJson();
    }
    if (tuesday != null) {
      data['Tue'] = tuesday!.toJson();
    }
    if (wednesday != null) {
      data['Wed'] = wednesday!.toJson();
    }
    return data;
  }
}
