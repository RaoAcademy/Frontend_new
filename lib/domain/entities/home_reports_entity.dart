// To parse this JSON data, do
//
//     final homeReportsEntity = homeReportsEntityFromJson(jsonString);

import 'dart:convert';

HomeReportsEntity homeReportsEntityFromJson(String str) => HomeReportsEntity.fromJson(json.decode(str) as Map<String,dynamic>);

String homeReportsEntityToJson(HomeReportsEntity data) => json.encode(data.toJson());

class HomeReportsEntity {
  Reports? reports;

  HomeReportsEntity({
    this.reports,
  });

  factory HomeReportsEntity.fromJson(Map<String, dynamic> json) => HomeReportsEntity(
    reports: Reports.fromJson(json["reports"] as Map<String,dynamic>),
  );

  Map<String, dynamic> toJson() => {
    "reports": reports?.toJson(),
  };
}

class Reports {
  Activity? activity;
  int? noOfPracticeTests;
  int? noOfTests;
  Activity? performance;
  Map<String, Activity>? progress;
  List<String>? subjectList;
  int? time;

  Reports({
    this.activity,
    this.noOfPracticeTests,
    this.noOfTests,
    this.performance,
    this.progress,
    this.subjectList,
    this.time,
  });

  factory Reports.fromJson(Map<String, dynamic> json) => Reports(
    activity: Activity.fromJson(json["Activity"] as Map<String,dynamic>),
    noOfPracticeTests: json["NoOfPracticeTests"] as int? ,
    noOfTests: json["NoOfTests"] as int?,
    performance: Activity.fromJson(json["Performance"] as Map<String,dynamic>),
    progress: Map.from(json["Progress"] as Map<String,dynamic>).map((k, v) => MapEntry<String, Activity>(k as String, Activity.fromJson(v as Map<String,dynamic>))),
    subjectList: List<String>.from(json["subjectList"].map((x) => x) as Iterable<dynamic>),
    time: json["time"] as int?,
  );

  Map<String, dynamic> toJson() => {
    "Activity": activity?.toJson(),
    "NoOfPracticeTests": noOfPracticeTests,
    "NoOfTests": noOfTests,
    "Performance": performance?.toJson(),
    "Progress": Map.from(progress as Map<String,dynamic>).map((k, v) => MapEntry<String, dynamic>(k as String, v.toJson())),
    "subjectList": List<dynamic>.from(subjectList!.map((x) => x)),
    "time": time,
  };
}

class Activity {
  int? fri;
  int? mon;
  int? sat;
  int? sun;
  int? thu;
  int? tue;
  int? wed;

  Activity({
    this.fri,
    this.mon,
    this.sat,
    this.sun,
    this.thu,
    this.tue,
    this.wed,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    fri: json["Fri"] as int?,
    mon: json["Mon"] as int?,
    sat: json["Sat"] as int?,
    sun: json["Sun"] as int?,
    thu: json["Thu"] as int?,
    tue: json["Tue"] as int?,
    wed: json["Wed"] as int?,
  );

  Map<String, dynamic> toJson() => {
    "Fri": fri,
    "Mon": mon,
    "Sat": sat,
    "Sun": sun,
    "Thu": thu,
    "Tue": tue,
    "Wed": wed,
  };
}
