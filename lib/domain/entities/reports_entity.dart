// To parse this JSON data, do
//
//     final reportsEntity = reportsEntityFromJson(jsonString);

import 'dart:convert';

import 'package:EdTestz/domain/entities/subject_list_entity.dart';
import 'package:EdTestz/domain/entities/time_entity.dart';

ReportsEntity reportsEntityFromJson(String str) => ReportsEntity.fromJson(json.decode(str) as Map<String,dynamic>);

String reportsEntityToJson(ReportsEntity data) => json.encode(data.toJson());

class ReportsEntity {
  int? accuracy;
  Badge? badge;
  int? confidence;
  Insights? insights;
  int? performance;
  List<dynamic>? recommendedTests;
  int? score;
  int? status;
  String? strongSubject;
  String? strongSubjectImage;
  List<SubjectList>? subjectList;
  int? tests;
  List<Time>? time;
  String? weakSubject;
  String? weakSubjectImage;

  ReportsEntity({
    this.accuracy,
    this.badge,
    this.confidence,
    this.insights,
    this.performance,
    this.recommendedTests,
    this.score,
    this.status,
    this.strongSubject,
    this.strongSubjectImage,
    this.subjectList,
    this.tests,
    this.time,
    this.weakSubject,
    this.weakSubjectImage,
  });

  factory ReportsEntity.fromJson(Map<String, dynamic> json) => ReportsEntity(
    accuracy: json["accuracy"] as int?,
    badge: Badge.fromJson(json["badge"] as Map<String,dynamic>),
    confidence: json["confidence"] as int?,
    insights: Insights.fromJson(json["insights"] as Map<String,dynamic>),
    performance: json["performance"] as int?,
    recommendedTests: json["recommended tests"] == null ? null :List<dynamic>.from(json["recommended tests"].map((x) => x) as Iterable<dynamic>),
    score: json["score"] as int?,
    status: json["status"] as int?,
    strongSubject: json["strong subject"] as String?,
    strongSubjectImage: json["strong subject Image"]  as String?,
    subjectList: List<SubjectList>.from(json["subjectList"].map((x) => SubjectList.fromJson(x as Map<String,dynamic>)) as Iterable<dynamic>),
    tests: int.parse(json["tests"].toString().split(".").first) as int?,
    time: List<Time>.from(json["time"].map((x) => Time.fromJson(x as Map<String,dynamic>)) as Iterable<dynamic>),
    weakSubject: json["weak subject"] as String?,
    weakSubjectImage: json["weak subject Image"]  as String?,
  );

  Map<String, dynamic> toJson() => {
    "accuracy": accuracy,
    "badge": badge?.toJson(),
    "confidence": confidence,
    "insights": insights?.toJson(),
    "performance": performance,
    "recommended tests": List<dynamic>.from(recommendedTests!.map((x) => x)),
    "score": score,
    "status": status,
    "strong subject": strongSubject,
    "strong subject Image": strongSubjectImage,
    "subjectList": List<dynamic>.from(subjectList!.map((x) => x.toJson())),
    "tests": tests,
    "time": List<dynamic>.from(time!.map((x) => x.toJson())),
    "weak subject": weakSubject,
    "weak subject Image": weakSubjectImage,
  };
}

class Badge {
  Activity? activity;
  int? noOfPracticeTests;
  int? noOfTests;
  Activity? performance;
  Map<String, Activity>? progress;
  List<String>? subjectList;
  int? time;

  Badge({
    this.activity,
    this.noOfPracticeTests,
    this.noOfTests,
    this.performance,
    this.progress,
    this.subjectList,
    this.time,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => Badge(
    activity: Activity.fromJson(json["Activity"] as Map<String,dynamic>),
    noOfPracticeTests: json["NoOfPracticeTests"]as int?,
    noOfTests: json["NoOfTests"]as int?,
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
    "Progress": Map.from(progress!).map((k, v) => MapEntry<String, dynamic>(k as String, v.toJson())),
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

class Insights {
  List<String>? badBehaviour;
  List<String>? goodBehaviour;

  Insights({
    this.badBehaviour,
    this.goodBehaviour,
  });

  factory Insights.fromJson(Map<String, dynamic> json) => Insights(
    badBehaviour: List<String>.from(json["bad behaviour"].map((x) => x) as Iterable<dynamic>),
    goodBehaviour: List<String>.from(json["good behaviour"].map((x) => x) as Iterable<dynamic>),
  );

  Map<String, dynamic> toJson() => {
    "bad behaviour": List<dynamic>.from(badBehaviour!.map((x) => x)),
    "good behaviour": List<dynamic>.from(goodBehaviour!.map((x) => x)),
  };
}




